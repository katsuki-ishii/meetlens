# MeetLens WBS（Work Breakdown Structure）

## 概要
**開発手法**: 仕様駆動開発（SDD - Specification-Driven Development）

流れ: SDD基盤準備 → 仕様ドキュメント作成 → 実装 の3フェーズ構成でMVPリリースまでのタスクを管理。

タスク管理: [GitHub Projects](https://github.com/users/katsuki-ishii/projects/1)（カンバン）
詳細タスクは各Issueを参照。

---

## Done
- #1 プロジェクト初期化（Phase 0）
- #2 フロントエンド環境構築（Phase 1）
- #4 IaC環境構築（Phase 1）

## In Progress
- #3 バックエンド環境構築（Phase 1）— sam.yaml/SAM Local は Phase 3 で実施

## Todo（Phase 1）
- #5 CI/CD基盤準備 — 実装が進んでから実施

## Todo（Phase 2: 仕様ドキュメント作成）
- #6 データモデル・DB設計仕様
- #7 API仕様書作成
- #8 VTTパーサー仕様
- #9 スコアリング・分析アルゴリズム仕様
- #10 UI/UX仕様
- #11 認証フロー仕様
- #12 コード規約・ルール策定

## Todo（Phase 3: 実装）— 仕様確定後にIssue化
- バックエンド実装（VTTパーサー、LLM連携、スコアリング、Lambda）
- フロントエンド実装（コンポーネント、状態管理、API連携、ルーティング）
- IaC実装（Terraform リソース、SAMテンプレート）
- デプロイ・テスト（統合テスト、ステージング、本番）
