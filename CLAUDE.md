# CLAUDE.md

## プロジェクト概要

**MeetLens** - 会議品質分析ツール。VTTトランスクリプト → 議事録生成 + スコアリング。

## テック スタック

- **Frontend**: Vue 3 + TypeScript + PrimeVue
- **Backend**: Python Lambda
- **LLM**: Amazon Bedrock
- **DB**: DynamoDB（`TenantID` パーティション）
- **Auth**: Cognito
- **Storage**: S3
- **IaC**: SAM + Terraform

## コマンド

```bash
# Frontend
cd frontend && npm install && npm run dev

# Backend
cd backend && pip install -r requirements.txt && make test

# IaC
cd infra/terraform && terraform init && terraform plan -var-file=environments/dev.tfvars
```

## 重要な注意点

- **テナント分離**: 全DynamoDBクエリは `TenantID` でフィルタ必須
- **VTT パーサー**: WebVTT形式。日本語音声認識誤りはLLMに補正させる
- **会議タイプ別スコア**: 定例・スクラム・1on1・ブレスト で異なる重み付け
- **JSON in DB**: DynamoDBのJSON が唯一の真実のソース

## 詳細ドキュメント

- [アーキテクチャ](docs/architecture.md)
- [開発ガイド](docs/development.md)
- [WBS](docs/wbs.md)
- [プロジェクト概要](meetlens-concept.md)
