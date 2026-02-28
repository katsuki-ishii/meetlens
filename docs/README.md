# Documentation

MeetLensの設計ドキュメント、API仕様、アーキテクチャ資料。

## ドキュメント構成
```
docs/
├── architecture/        # アーキテクチャ・設計
│   ├── overview.md
│   ├── data-model.md
│   └── workflow.md
├── api/                 # API仕様
│   ├── rest-api.md
│   └── examples.md
├── vtt-parser/          # VTT解析仕様
│   └── spec.md
├── scoring/             # スコアリング仕様
│   ├── metrics.md
│   └── weights.md
├── ui/                  # UI/UX設計
│   ├── screens.md
│   └── components.md
└── development/         # 開発ガイド
    ├── setup.md
    ├── testing.md
    └── deployment.md
```

## 主要ドキュメント
- **architecture/overview.md** - システム全体図と各コンポーネント間の関係
- **api/rest-api.md** - フロントエンド↔バックエンド間のAPI仕様
- **vtt-parser/spec.md** - VTTファイルの解析・データ抽出ロジック
- **scoring/metrics.md** - 会議品質スコアの計算ロジック

## リンク
- 概要: ../meetlens-concept.md（プロジェクト概要）
- 開発ガイド: ../CLAUDE.md（Claude Code用ガイダンス）
