# Infrastructure

AWS リソースの定義・管理。SAM（Lambda向け）とTerraform（基盤部分）を使用。

## ディレクトリ構成
```
infra/
├── sam/
│   ├── template.yaml     # Lambda、API Gateway 定義
│   └── parameters.json   # 環境別パラメータ
├── terraform/
│   ├── main.tf           # メインリソース定義
│   ├── variables.tf      # 変数定義
│   ├── outputs.tf        # 出力定義
│   ├── cognito.tf        # 認証（Cognito）
│   ├── dynamodb.tf       # データベース
│   ├── s3.tf             # ストレージ
│   ├── iam.tf            # IAMロール・ポリシー
│   └── environments/     # 環境別 tfvars ファイル
└── README.md
```

## デプロイフロー

### SAM（Lambda/API Gateway）
```bash
cd infra/sam
sam build
sam deploy      # 初回、または手動デプロイ
```

### Terraform（コア インフラ）
```bash
cd infra/terraform
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

## リソース一覧
- **Cognito**: ユーザー認証・テナント管理
- **Lambda**: 関数実行
- **API Gateway**: REST API エンドポイント
- **DynamoDB**: テーブル（Meetings、Analytics等）
- **S3**: VTTファイル、生成HTMLストレージ
- **IAM**: ロール・ポリシー（最小権限の原則）

## 環境管理
- dev（開発）
- staging（ステージング）
- prod（本番）

各環境の設定は `environments/` 配下の `.tfvars` ファイルで管理。
