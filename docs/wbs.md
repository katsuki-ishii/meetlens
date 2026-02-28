# MeetLens WBS（Work Breakdown Structure）

## 概要
**開発手法**: 仕様駆動開発（SDD - Specification-Driven Development）

流れ: SDD基盤準備 → 仕様ドキュメント作成 → 実装 の3フェーズ構成でMVPリリースまでのタスクを管理。

---

## Phase 0: SDD基盤準備（仕様駆動開発の準備）

### 0.1 プロジェクト初期化（完了）
- [x] Git リポジトリ初期化
  - [x] git init
  - [x] GitHub リモート設定（git@github.com:katsuki-ishii/meetlens.git）
  - [x] 初期コミット・push
- [x] プロジェクト構造構築
  - [x] frontend/、backend/、infra/、docs/ ディレクトリ作成
  - [x] 各パスに README.md 作成
- [x] ドキュメント・設定作成
  - [x] CLAUDE.md（Claude Code ガイダンス、プロジェクト性質・制約記載）
  - [x] meetlens-concept.md（プロジェクト概要）
  - [x] WBS（このファイル）
  - [x] Claude Code 言語・モデル設定（Japanese、Opus）
- [x] SDD ディレクトリ構成準備（本フェーズ進行中）
  - [ ] docs/specs/ ディレクトリ作成（仕様ドキュメント置き場）
  - [ ] .claude/rules/ ディレクトリ作成（コード規約置き場）

---

## Phase 1: 環境準備

### 1.0 プロジェクト初期化（完了）
- [x] Git リポジトリ初期化
  - [x] git init
  - [x] GitHub リモート設定（git@github.com:katsuki-ishii/meetlens.git）
  - [x] 初期コミット・push
- [x] プロジェクト構造構築
  - [x] frontend/、backend/、infra/、docs/ ディレクトリ作成
  - [x] 各パスに README.md 作成
- [x] ドキュメント作成
  - [x] CLAUDE.md（Claude Code ガイダンス）
  - [x] meetlens-concept.md（プロジェクト概要）
  - [x] WBS（このファイル）
- [x] 開発環境設定
  - [x] Claude Code 言語設定（Japanese）
  - [x] Claude Code モデル設定（Opus）

### 1.1 フロントエンド環境構築
- [ ] Vue 3 + TypeScript プロジェクト初期化
  - [ ] Vite による プロジェクトセットアップ
  - [ ] TypeScript 設定（tsconfig.json）
  - [ ] ESLint + Prettier 設定
- [ ] PrimeVue インストール・設定
  - [ ] コンポーネントライブラリ統合
  - [ ] テーマ選択・カスタマイズ
- [ ] 状態管理（Pinia）セットアップ
  - [ ] ストア構造設計・初期化
- [ ] Vitest + Vue Test Utils テスト環境構築

### 1.2 バックエンド環境構築
- [ ] Python Lambda 開発環境
  - [ ] Python 3.x + pip 環境
  - [ ] requirements.txt 作成（Bedrock SDK、boto3 等）
- [ ] AWS SAM CLI インストール・設定
  - [ ] sam.yaml テンプレート初期化
  - [ ] ローカルデバッグ環境（SAM Local）
- [ ] DynamoDB Local 開発環境
  - [ ] Docker または DynamoDB Local インストール
- [ ] pytest + moto テスト環境（AWS mocking）

### 1.3 IaC環境構築
- [ ] Terraform 初期化
  - [ ] terraform/ ディレクトリ構造
  - [ ] .gitignore（.tfstate 等）
  - [ ] 環境別 tfvars ファイル（dev.tfvars, prod.tfvars）
- [ ] SAM テンプレート（sam.yaml）の確立
- [ ] AWS 認証情報の設定
  - [ ] AWS CLI configure
  - [ ] 必要な IAM ロール確認

### 1.4 CI/CD 基盤準備
- [ ] GitHub Actions ワークフロー初期化
  - [ ] Lint + テスト自動化
  - [ ] デプロイメント パイプライン（dev/prod）
- [ ] .github/workflows/ 作成
- [ ] 環境変数・シークレット管理（GitHub Secrets）

---

## Phase 2: 仕様ドキュメント作成（SDD：仕様が実装の源）

このフェーズで作成される仕様ドキュメント（docs/specs/）が、実装判断の根拠となる。全ての実装はこの仕様から導出される。

### 2.1 API仕様書作成（docs/specs/api.md）
- [ ] DynamoDB スキーマ定義
  - [ ] Meetings テーブル（PK: TenantID + MeetingID）
  - [ ] Analytics テーブル（会議スコア・メトリクス）
  - [ ] Users テーブル（Cognito 連携）
  - [ ] インデックス（GSI）設計
- [ ] 従量制フリー度合い検討（オンデマンド vs プロビジョニング）
- [ ] データ保持ポリシー（TTL 設定等）

### 2.2 API 仕様書作成
- [ ] REST API エンドポイント定義（OpenAPI/Swagger 形式）
  - [ ] 認証（POST /auth/login）
  - [ ] VTT アップロード（POST /meetings/upload）
  - [ ] 会議取得（GET /meetings, GET /meetings/{id}）
  - [ ] 分析結果取得（GET /meetings/{id}/analytics）
- [ ] リクエスト/レスポンス スキーマ詳細定義
- [ ] エラーハンドリング・ステータスコード仕様

### 2.2 データモデル・DB設計仕様（docs/specs/data-model.md）
- [ ] DynamoDB スキーマ定義
  - [ ] Meetings テーブル（PK: TenantID + MeetingID）
  - [ ] Analytics テーブル（会議スコア・メトリクス）
  - [ ] Users テーブル（Cognito 連携）
  - [ ] インデックス（GSI）設計
- [ ] スキーマ詳細（型、制約、デフォルト値）
- [ ] データ保持ポリシー（TTL 設定等）

### 2.3 VTT パーサー仕様（docs/specs/vtt-parser.md）
- [ ] VTT ファイル形式の詳細解析
  - [ ] WEBVTT ヘッダー、メタデータ取得
  - [ ] タイムスタンプ範囲（HH:MM:SS.mmm --> HH:MM:SS.mmm）
  - [ ] 話者名抽出ロジック
  - [ ] テキスト本体抽出
- [ ] 言語別対応（日本語音声認識誤り補正戦略）
- [ ] エッジケース処理（複数話者、タイムコード欠落 等）

### 2.4 スコアリング・分析アルゴリズム仕様（docs/specs/scoring.md）
- [ ] 会議タイプごとのメトリクス定義
  - [ ] **定例**：意思決定数、脱線率、時間効率
  - [ ] **デイリースクラム**：実施時間、発言均等性
  - [ ] **1on1**：部下発言比率、アクションアイテム
  - [ ] **ブレスト・振り返り**：新規アイデア数、多様性
- [ ] スコアリング重み付けテーブル
- [ ] 品質判定基準（優秀/良好/改善必要 等）

### 2.5 UI/UX 仕様（docs/specs/ui.md）
- [ ] ページ遷移図・フロー設計
  - [ ] ログイン → ダッシュボード → 詳細画面
  - [ ] VTT アップロードモーダル
- [ ] 画面モックアップ作成
  - [ ] ダッシュボード（会議一覧・サマリー）
  - [ ] 会議詳細ページ（議事録・分析結果表示）
  - [ ] メタデータ入力フォーム
- [ ] コンポーネント設計書

### 2.6 認証フロー仕様（docs/specs/auth.md）
- [ ] Cognito ユーザープール設定
  - [ ] ユーザー属性（TenantID 等）
  - [ ] パスワードポリシー
- [ ] JWT トークン管理戦略
  - [ ] トークン有効期限、リフレッシュトークン
  - [ ] フロントエンド・バックエンド間の検証

### 2.7 コード規約・ルール（.claude/rules/）
- [ ] フロントエンド規約（.claude/rules/frontend.md）
  - [ ] ファイル命名規約、ディレクトリ構成
  - [ ] Vue 3・TypeScript コーディング規約
  - [ ] コンポーネント設計パターン
  - [ ] 状態管理（Pinia）ルール
- [ ] バックエンド規約（.claude/rules/backend.md）
  - [ ] ファイル命名規約、ディレクトリ構成
  - [ ] Python コーディング規約
  - [ ] Lambda 関数設計パターン
  - [ ] エラーハンドリング・ロギング規約

---

## Phase 3: 実装

### 3.1 バックエンド実装

#### 3.1.1 VTT パーサー実装
- [ ] vtt_parser.py 実装
  - [ ] VTT ファイル読み込み・パース
  - [ ] 話者・タイムスタンプ・テキスト抽出
  - [ ] 構造化データ（List[Dict]）に変換
- [ ] エッジケース対応（テスト含む）
- [ ] ユニットテスト作成（90%+ カバレッジ目標）

#### 3.1.2 LLM 連携実装
- [ ] llm.py 実装（Bedrock 呼び出し）
  - [ ] Bedrock クライアント初期化
  - [ ] 議事録生成プロンプト設計
  - [ ] 分析プロンプト設計（スコアリング）
  - [ ] レスポンス パース
- [ ] プロンプトチューニング・テスト
- [ ] コスト・レイテンシー測定

#### 3.1.3 スコアリング実装
- [ ] metrics.py 実装
  - [ ] 意思決定検出ロジック
  - [ ] 発言量分析（話者別・時間別）
  - [ ] 脱線率計算
  - [ ] 会議タイプ別スコア算出
- [ ] ユニットテスト

#### 3.1.4 Lambda ハンドラー実装
- [ ] upload.py
  - [ ] VTT ファイル受け取り
  - [ ] S3 アップロード
  - [ ] DynamoDB レコード作成
- [ ] analyze.py
  - [ ] VTT 解析・Bedrock 呼び出し
  - [ ] スコア計算・保存
- [ ] retrieve.py
  - [ ] 会議一覧取得（ページネーション含む）
  - [ ] 詳細データ取得
- [ ] エラーハンドリング・ロギング
- [ ] 統合テスト

### 3.2 フロントエンド実装

#### 3.2.1 コンポーネント実装
- [ ] 共通コンポーネント
  - [ ] Header・Navigation
  - [ ] Footer
  - [ ] Loading Spinner、Error Alert
- [ ] ページコンポーネント
  - [ ] LoginPage
  - [ ] DashboardPage（会議一覧）
  - [ ] MeetingDetailPage
  - [ ] UploadPage

#### 3.2.2 状態管理実装
- [ ] Pinia ストア
  - [ ] authStore（ログイン状態、トークン）
  - [ ] meetingStore（会議データ）
  - [ ] uiStore（ローディング、エラー状態）

#### 3.2.3 API 呼び出し実装
- [ ] services/api.ts
  - [ ] HTTP クライアント（axios 等）
  - [ ] Cognito トークン自動付加
  - [ ] エラーハンドリング
- [ ] エンドポイント別関数作成

#### 3.2.4 ルーティング・認証ガード
- [ ] Vue Router 設定
  - [ ] ルート定義
  - [ ] 認証ガード（ログイン必須ページ）
- [ ] リダイレクト処理

#### 3.2.5 テスト実装
- [ ] ユニットテスト（Vitest）
  - [ ] コンポーネントテスト
  - [ ] Pinia ストアテスト
- [ ] E2E テスト（必要に応じて Playwright）

### 3.3 IaC 実装

#### 3.3.1 Terraform 実装
- [ ] main.tf（プロバイダー、リージョン等）
- [ ] cognito.tf（Cognito ユーザープール・クライアント）
- [ ] dynamodb.tf（テーブル・インデックス定義）
- [ ] s3.tf（VTT ストレージ、HTML 出力）
- [ ] iam.tf（Lambda 実行ロール・ポリシー）
- [ ] outputs.tf（API エンドポイント等を出力）

#### 3.3.2 SAM テンプレート実装
- [ ] sam.yaml
  - [ ] Lambda 関数定義（upload, analyze, retrieve）
  - [ ] API Gateway エンドポイント
  - [ ] 環境変数設定
  - [ ] 関数間のポリシー定義

#### 3.3.3 本番環境対応
- [ ] dev, prod 環境別設定
  - [ ] tfvars ファイル分岐
  - [ ] Lambda メモリ・タイムアウト調整
  - [ ] DynamoDB 容量設定（オンデマンド vs プロビジョニング）
- [ ] バージョニング戦略

### 3.4 デプロイ・テスト

#### 3.4.1 統合テスト
- [ ] バックエンド統合テスト（aws-cdk-lib 等）
  - [ ] VTT アップロード → 分析 → 取得 の E2E
- [ ] フロントエンド統合テスト
  - [ ] ローカル開発環境での動作確認

#### 3.4.2 ステージング環境デプロイ
- [ ] Terraform apply（dev 環境）
- [ ] Lambda 関数デプロイ（SAM）
- [ ] フロントエンド S3 デプロイ・CloudFront 設定
- [ ] 動作確認テスト

#### 3.4.3 本番環境デプロイ準備
- [ ] Terraform apply（prod 環境）
- [ ] セキュリティ監査
  - [ ] IAM 最小権限確認
  - [ ] 暗号化設定確認（S3, DynamoDB）
  - [ ] API 認証・CORS 設定
- [ ] パフォーマンステスト（負荷テスト）
- [ ] ロールバック計画策定

#### 3.4.4 本番リリース
- [ ] CI/CD パイプライン実行
- [ ] モニタリング・ログ設定（CloudWatch）
- [ ] 本番環境動作確認
- [ ] ユーザー向けドキュメント・ガイド作成

---

## Status Legend
- [ ] 未開始（Pending）
- [x] 完了（Completed）
- [~] 進行中（In Progress）
