# Frontend

Vue 3 + TypeScript + PrimeVueで構築するMeetLensのWebUI。

## ディレクトリ構成
```
frontend/
├── src/
│   ├── components/        # 再利用可能なUIコンポーネント
│   ├── pages/            # ページレベルのビュー
│   ├── stores/           # Pinia ストア（状態管理）
│   ├── services/         # API呼び出し、ビジネスロジック
│   ├── types/            # TypeScript型定義
│   ├── App.vue
│   └── main.ts
├── public/               # 静的アセット
├── tests/                # テストファイル
├── package.json
├── tsconfig.json
└── vite.config.ts
```

## セットアップ
```bash
npm install
npm run dev      # 開発サーバー起動
npm run build    # 本番ビルド
npm run lint     # Lint実行
npm run test     # テスト実行
```

## 主要ページ
- ログイン画面
- VTTアップロード画面
- 会議一覧（ダッシュボード）
- 会議詳細ページ（議事録・分析結果表示）

## 状態管理
Piniaを使用した集中型状態管理:
- 認証状態（ユーザー、トークン）
- 会議データ
- UI状態（ローディング、エラー）
