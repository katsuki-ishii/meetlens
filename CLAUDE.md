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

## 制約

### コスト制約
- 個人開発なので AWS 費用を最小化必須
- Lambda 実行時間・メモリサイズが直結（ billable duration × memory）
- DynamoDB オンデマンド課金 → スパイク費用に注意
- Bedrock API 呼び出しコストが主要費用

### 技術的制約
- **Lambda**: 実行時間 15分、メモリ 10GB、同時実行数リージョン制限
- **VTT 大容量ファイル**: Step Functions で分割処理検討必要
- **イベント駆動・ステートレス設計** 必須
- **CloudWatch ログ** に依存（traditional APM 難しい）
- **Bedrock リージョン限定** (us-west-2 等)

### スケーラビリティ制約
- Lambda 同時実行数制限（リージョン別、デフォルト 1000）
- DynamoDB スループット（オンデマンド時も上限あり）
- S3 リクエストレート（無制限に近いが、実装工夫必要）

### 開発スキル制約
- 個人開発なので自分で運用・デバッグできる範囲に限定
- AWS サービス複雑化は技術負債の可能性 → シンプル設計優先

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
