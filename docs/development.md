# 開発ガイド

## ローカル開発環境セットアップ

### 前提条件

- Node.js 16+ (フロントエンド)
- Python 3.9+ (バックエンド)
- AWS CLI + 認証情報（dev環境アクセス用）
- Docker（DynamoDB Local実行用）
- Terraform 1.0+

### フロントエンド環境

```bash
cd frontend
npm install

# 開発サーバー起動（ポート 5173）
npm run dev

# ビルド
npm run build

# テスト
npm run test

# Lint
npm run lint
```

**主な依存:**
- vue@3
- typescript
- @vueuse/core
- pinia (状態管理)
- primevue (コンポーネントライブラリ)
- axios (HTTP クライアント)
- vitest (テストフレームワーク)

### バックエンド環境

```bash
cd backend

# 依存インストール
pip install -r requirements.txt

# SAM ビルド
sam build

# ローカル実行（DynamoDB Local必要）
sam local start-api

# テスト
pytest

# 特定テストのみ
pytest tests/test_vtt_parser.py -v
```

**DynamoDB Local セットアップ:**
```bash
# Docker Compose で起動（infra/docker-compose.yml 参照）
docker-compose -f infra/docker-compose.yml up dynamodb-local
```

**主な依存:**
- boto3 (AWS SDK)
- anthropic-bedrock (LLM)
- pydantic (データ検証)
- pytest (テストフレームワーク)
- moto (AWS モック)

### IaC環境

```bash
cd infra/terraform

# Terraform 初期化
terraform init

# 開発環境プラン確認
terraform plan -var-file=environments/dev.tfvars

# 開発環境デプロイ
terraform apply -var-file=environments/dev.tfvars

# 本番環境プラン確認（要慎重）
terraform plan -var-file=environments/prod.tfvars

# 本番環境デプロイ（確認必須）
terraform apply -var-file=environments/prod.tfvars
```

## コード規約

### フロントエンド

- **ファイル命名**: PascalCase (コンポーネント), camelCase (その他)
- **テンプレート**: `<template>` → `<script>` → `<style scoped>` の順
- **型定義**: TypeScript 使用、明示的な型付け
- **状態管理**: Pinia ストア使用（Vue Composition APIと組み合わせ）

### バックエンド

- **ファイル命名**: snake_case
- **関数**: docstring 必須、型ヒント推奨
- **例外**: AWS関連は `boto3.exceptions` をキャッチ、独自例外定義可
- **ログ**: `logging` モジュール使用

## テスト戦略

### フロントエンド

```bash
npm run test
```

カバレッジ目標: 80%+

### バックエンド

```bash
pytest --cov=src tests/
```

カバレッジ目標: 90%+

**テストスコープ:**
- ユニットテスト (VTT パーサー、スコア計算)
- 統合テスト (Lambda ハンドラー、DynamoDB)
- モック: moto で AWS サービス モック

## デバッグ

### Lambda ローカルデバッグ

```bash
sam local start-api --debug
```

VS Code で `launch.json` に設定追加可能。

### DynamoDB Local 確認

```bash
# テーブル一覧確認
aws dynamodb list-tables --endpoint-url http://localhost:8000

# データ参照
aws dynamodb scan --table-name Meetings --endpoint-url http://localhost:8000
```

## CI/CD

GitHub Actions で自動テスト・デプロイを実行。

詳細は `.github/workflows/` を参照。

## 重要な注意点

1. **AWS 認証情報**: `.aws/credentials` に設定、.gitignore に追加済み
2. **テナントID**: 全DynamoDB操作は必ず `TenantID` でフィルタ
3. **VTT ファイル**: 手動アップロードのみ（MVP）、API自動取得は将来対応
4. **Bedrock**: リージョン限定（us-east-1 等）、API呼び出し制限注意
5. **環境変数**: .env.local で管理、本番シークレットはAWS Secrets Manager

## トラブルシューティング

**DynamoDB Local 接続エラー**
```bash
# ポート 8000 で起動確認
curl http://localhost:8000
```

**Bedrock 呼び出しエラー**
- リージョン確認（us-west-2, us-east-1 等で利用可能）
- API キー確認（IAM ロール権限確認）

**Lambda タイムアウト**
- VTT ファイルサイズ確認
- Bedrock API レイテンシ確認（改善案: 非同期処理検討）
