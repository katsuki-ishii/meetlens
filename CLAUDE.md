# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

**MeetLens** は会議の品質を分析・可視化するWebアプリケーション。VTT（字幕ファイル）トランスクリプトを処理して、議事録自動生成と品質スコアリングを実施。組織の会議文化改善を目的とする個人開発プロジェクト。

**MVP**: VTT（Teams/Zoom/Webex対応）アップロード → 議事録生成 → 品質分析 → ダッシュボード表示

## テック スタック

| レイヤー | 技術 |
|---------|------|
| フロントエンド | Vue 3 + TypeScript + PrimeVue |
| バックエンド | Python Lambda |
| LLM | Amazon Bedrock |
| DB | Amazon DynamoDB |
| 認証 | Amazon Cognito |
| ストレージ | Amazon S3 |
| IaC | SAM + Terraform |

**重要な設計判断:**
- **テナント優先**: DynamoDBスキーマは`TenantID`をPKとして設計（MVPでも複数テナント対応を前提）
- **会議タイプ別スコア**: 定例・デイリースクラム・1on1・ブレスト で異なる評価ロジック
- **JSON in DB**: HTMLは補助的、DynamoDBのJSON が唯一の真実のソース

## ファイル構成

```
frontend/         Vue 3 プロジェクト
backend/          Python Lambda 関数
infra/            SAM テンプレート + Terraform
docs/             アーキテクチャ・API仕様・開発ガイド
```

詳細は [docs/architecture.md](docs/architecture.md) を参照。

## コマンド リファレンス

### フロントエンド
```bash
cd frontend
npm install && npm run dev      # 開発サーバー起動
npm run build                   # ビルド
npm run test                    # テスト
```

### バックエンド
```bash
cd backend
pip install -r requirements.txt
make build                      # SAM ビルド
make test                       # テスト
```

### IaC
```bash
cd infra/terraform
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

詳細は [docs/development.md](docs/development.md) を参照。

## プロジェクト固有の注意点

- **VTT パーサー**: WebVTT形式。日本語音声認識誤りはLLMに文脈補正させる
- **AWS認証**: ローカルテストに AWS CLI 認証情報が必須（Bedrock、DynamoDB、S3）
- **テナント分離**: 全DynamoDB クエリは`TenantID`でフィルタ必須
- **スコア重み付け**: 会議タイプごとに異なる。backend/services/metrics.py 参照

## 関連ドキュメント

- [プロジェクト概要](meetlens-concept.md)
- [WBS・タスク管理](docs/wbs.md)
- [アーキテクチャ詳細](docs/architecture.md)
- [開発ガイド](docs/development.md)
