# Backend

Python Lambdaで構築するMeetLensのバックエンド。VTT解析、LLM呼び出し、データ処理を担当。

## ディレクトリ構成
```
backend/
├── src/
│   ├── handlers/         # Lambda ハンドラー関数
│   │   ├── upload.py     # VTTアップロード処理
│   │   ├── analyze.py    # VTT解析・スコアリング
│   │   └── retrieve.py   # 会議データ取得
│   ├── services/         # ビジネスロジック
│   │   ├── vtt_parser.py # VTT解析
│   │   ├── llm.py        # Bedrock連携
│   │   └── metrics.py    # スコア計算
│   ├── models/          # DynamoDB モデル・操作
│   └── utils/           # ユーティリティ関数
├── tests/               # テストファイル
├── requirements.txt
├── sam.yaml             # SAM テンプレート
└── Makefile             # 開発用コマンド
```

## セットアップ
```bash
pip install -r requirements.txt
make build    # SAM ビルド
make local    # ローカル実行（DynamoDB Local等が必要）
make test     # テスト実行
```

## Lambda関数
- **upload**: VTTファイル受け取り、S3へ保存、DB登録
- **analyze**: VTT解析、Bedrock呼び出し、品質メトリクス計算
- **retrieve**: 会議データAPI（一覧取得、詳細取得）

## 外部サービス連携
- **Amazon Bedrock**: テキスト生成・分析用LLM
- **Amazon DynamoDB**: データベース
- **Amazon S3**: ファイルストレージ
- **AWS Lambda**: 実行環境
