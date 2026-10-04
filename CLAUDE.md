# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

**MeetLens** は会議の品質を分析・可視化するWebアプリケーション。VTT（字幕ファイル）トランスクリプトを処理して、議事録自動生成と品質スコアリングを実施。組織の会議文化改善を目的とする個人開発プロジェクト。

**MVP**: VTT（Teams/Zoom/Webex対応）アップロード → 議事録生成 → 品質分析 → ダッシュボード表示

## プロジェクトの性質
- このプロジェクトは学習目的の個人開発プロジェクトである。
- Bedrockやサーバーレスアーキテクチャの学習を主目的としている。
- またTypeScript、Python、Vue.js、Vuetifyの学習も含む。
- 個人開発かつ学習を主目的とするため、AWSの利用料は最低限になるような設計を心がける。（発生してもよいが月に1000円以下であることが望ましい。）

## タスク管理
- **GitHub Projects**（カンバン）で管理: https://github.com/users/katsuki-ishii/projects/1
- **進捗状態の正はGitHub Projects**。状態（Todo / In Progress / Done）はProjectsでのみ管理する。
- **docs/wbs.md** はフェーズ構成とIssueの対応を示す全体図。進捗状態は記載しない。
- **各GitHub Issue** に詳細なサブタスク（チェックリスト）を記載。
- タスク着手時はIssueのステータスを更新し、完了時はクローズする。`gh` コマンドで操作する。
- 新しいタスクが発生したらIssueを作成し、Projectに追加、wbs.mdの該当フェーズにIssue番号を追記する。

## 制約
- 開発者は日本人であるため、特に明示的な指示がない場合は日本語で答える。
- 開発者の理解負債を防ぐために、一度に大量のファイル生成は控える。
- ルートディレクトリのdocsを毎回確認し、実装と各種ルールや要件、docs/wbs.mdのフェーズ構成に不整合が起きないようにする。
- 小まめにgitへのコミットを行い、コミットメッセージもわかりやすく簡潔に残すこと。
- 危険な操作（削除・破壊・上書き）は必ず確認を取る。
- 実行前提が不明な場合、推測で作業せず、**実行前に必ず質問して確認すること**。
