# MeetLens WBS（Work Breakdown Structure）

## 概要
**開発手法**: 仕様駆動開発（SDD - Specification-Driven Development）

流れ: 基盤準備 → 環境構築 → 要件定義 → 仕様作成 → 実装 のフェーズ構成でMVPリリースまでのタスクを管理。

このファイルはフェーズ構成とIssueの対応を示す**全体図**であり、進捗状態は持たない。
進捗（Todo / In Progress / Done）は [GitHub Projects](https://github.com/users/katsuki-ishii/projects/1)（カンバン）を正とする。
詳細タスクは各Issueを参照。

---

## Phase 0: 基盤準備
- #1 プロジェクト初期化

## Phase 1: 環境構築
- #2 フロントエンド環境構築
- #3 バックエンド環境構築 — sam.yaml/SAM Local は Phase 3 に引き継ぎ
- #4 IaC環境構築
- #5 CI/CD基盤準備 — 実装が進んでから実施
- #14 UIライブラリをVuetifyに移行 — PrimeVue有料化のため
- #15 devcontainer による開発環境構築 — 複数PC（自宅・会社）で環境を再現するため
- #17 会社PCの開発環境セットアップ — #15 の devcontainer を会社PCで再現
- #18 Obsidian カンバンの導入 — GitHub Projects との役割分担を決める
- #19 Zed で devcontainer を試す — 任意

## 要件定義
- #13 MVP要件定義 — concept.md を元にスコープ・優先度を確定

## Phase 2: 仕様ドキュメント作成 — 要件定義の後に着手
- #6 データモデル・DB設計仕様
- #7 API仕様書作成
- #8 VTTパーサー仕様
- #9 スコアリング・分析アルゴリズム仕様
- #10 UI/UX仕様
- #11 認証フロー仕様
- #12 コード規約・ルール策定

## Phase 3: 実装 — 仕様確定後にIssue化
- #16 テスト環境の整備（pytest / Vitest / Playwright） — #2・#3 で導入したパッケージの設定と最初のテスト
- バックエンド実装（VTTパーサー、LLM連携、スコアリング、Lambda）
- フロントエンド実装（コンポーネント、状態管理、API連携、ルーティング）
- IaC実装（Terraform リソース、SAMテンプレート、SAM Localによるローカルデバッグ環境 ← #3 から引き継ぎ）
- デプロイ・テスト（統合テスト、ステージング、本番）
