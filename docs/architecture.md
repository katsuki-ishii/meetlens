# アーキテクチャ詳細

## システム概要

MeetLensは、会議のWebVTT形式トランスクリプトを入力として、以下を実施する3層構成のシステム：

1. **トランスクリプト処理** - VTTパース、LLMによる議事録生成
2. **品質分析** - メトリクス抽出、スコアリング
3. **可視化** - ダッシュボードとレポート表示

## 処理フロー

```
ユーザー（フロントエンド）
  ↓ VTT + メタデータアップロード
AWS API Gateway
  ↓
Lambda (upload)
  ├→ S3へファイル保存
  └→ DynamoDBへレコード作成
  ↓
Lambda (analyze)
  ├→ VTTパース
  ├→ Bedrock呼び出し（議事録生成・初期分析）
  ├→ スコア計算
  └→ DynamoDB更新
  ↓
Lambda (retrieve)
  ↓
フロントエンド（ダッシュボード・詳細表示）
```

## データモデル

### 主要テーブル

**Meetings**
- PK: `TenantID` (S)
- SK: `MeetingID` (S)
- Attributes:
  - `title` - 会議タイトル
  - `type` - 会議タイプ（regular/standup/1on1/brainstorm）
  - `date` - 開催日時
  - `vttS3Path` - S3内のVTTファイルパス
  - `duration` - 会議時間（分）
  - `speakers` - 話者リスト
  - `status` - 処理ステータス（pending/processing/completed）
  - `createdAt`, `updatedAt`

**Analytics**
- PK: `TenantID` (S)
- SK: `MeetingID` (S)
- Attributes:
  - `meetingMinutes` - 生成された議事録テキスト
  - `scores` - 各メトリクスのスコア
    ```
    {
      "decisionsCount": { "explicit": 3, "pending": 1, "unresolved": 0 },
      "actionItems": { "concrete": 2, "vague": 1 },
      "participationRatio": { "speaker1": 0.45, "speaker2": 0.35, ... },
      "digression_rate": 0.12,
      "overall_score": 78
    }
    ```
  - `quality_level` - 品質レベル（excellent/good/needs_improvement）

**Users** (Cognito連携)
- AWS Cognito User Poolで管理
- カスタム属性: `TenantID`

### インデックス

**Meetings**
- GSI: `TypeIndex` - PK: `TenantID`, SK: `type` (フィルタリング用)
- GSI: `DateIndex` - PK: `TenantID`, SK: `date` (時系列ソート用)

## 会議タイプ別スコアリング

### 定例（Regular）
重視指標：
- 意思決定数（40%）
- 脱線率（30%）
- 時間効率（30%）

### デイリースクラム
重視指標：
- 実施時間の短さ（50%）
- 発言の均等性（50%）

### 1on1
重視指標：
- 部下発言比率（50%、理想7割以上）
- アクションアイテムの具体性（50%）

### ブレスト・振り返り
重視指標：
- 新規アイデア数（50%）
- 話者多様性（50%）

## VTT フォーマット仕様

```
WEBVTT

00:00:00.000 --> 00:00:05.000
Speaker Name: 話された内容

00:00:05.000 --> 00:00:10.000
別の話者: 次の発言
```

**パーサの処理:**
1. WEBVTT ヘッダー確認
2. タイムスタンプ範囲を秒単位で抽出
3. 話者名と本文を分離
4. 構造化データ（List[Dict]）に変換

**エッジケース処理:**
- タイムスタンプ欠落 → スキップ
- 複数行発言 → 結合
- 日本語音声認識誤り → Bedrockに文脈補正させる

## API エンドポイント概要

| メソッド | パス | 説明 |
|---------|------|------|
| POST | `/meetings/upload` | VTTファイルアップロード |
| GET | `/meetings` | 会議一覧（ページネーション・フィルタ対応） |
| GET | `/meetings/{id}` | 会議詳細 |
| GET | `/meetings/{id}/analytics` | 分析結果 |

詳細は [docs/api/rest-api.md](api/rest-api.md) を参照。

## セキュリティ・テナント分離

- **認証**: Amazon Cognito（JWT トークン）
- **API Gateway**: トークン検証でリクエストからユーザー特定
- **Lambda**: ユーザーのTenantIDを取得、全DynamoDBクエリで`TenantID`フィルタ
- **S3**: TenantID別フォルダ構成（s3://bucket/tenants/{TenantID}/...）

## パフォーマンス・スケーラビリティ

- **Lambda**: 同時実行数制限なし（スケールアウト自動）
- **DynamoDB**: オンデマンド課金モード（スパイク対応）
- **S3**: 無制限スケール
- **Bedrock**: API呼び出し制限あり（リージョン別）

## 展開環境

| 環境 | 構成 | 用途 |
|-----|------|------|
| dev | 最小限 | 開発・テスト |
| prod | フル構成 | 本番運用 |

Terraform で環境別設定を管理（environments/*.tfvars）。
