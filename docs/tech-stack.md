# MeetLens 技術スタック

参照: [MVP要件定義](requirements/mvp.md)

---

## 構成

| レイヤー | 技術 |
|---|---|
| フロントエンド | Vue 3 + TypeScript + Vuetify |
| バックエンド | Python Lambda |
| AI/LLM | Amazon Bedrock |
| 認証 | Amazon Cognito |
| データベース | Amazon DynamoDB |
| ファイルストレージ | Amazon S3 |
| IaC | SAM（サーバーレス部分）/ Terraform（基盤部分） |
| CI/CD | GitHub Actions |

---

## LLM（Bedrock）
- モデル: **Claude Haiku 5.5**（推論プロファイル `jp.anthropic.claude-haiku-5-5`。国内リージョンで処理）
- モデルIDは設定値にし、品質が不足する場合は Sonnet 5.5 等へ切り替えられるようにする
- コスト目安: 1時間の会議で1件あたり約1円（入力約2.2万・出力約1万トークン、Anthropic公式単価で試算。Bedrock の実単価は要確認）
- VTTはタイムスタンプ等を除いて整形してからLLMに渡し、入力トークンを抑える
