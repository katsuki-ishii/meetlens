#!/usr/bin/env bash
# コンテナ作成時に1回だけ実行されるセットアップ
set -euo pipefail

sudo apt-get update
sudo apt-get install -y tree

# volume は root 所有で作られるため、vscode ユーザーが書けるようにする
sudo chown -R vscode:vscode /home/vscode/.claude /home/vscode/.codex /home/vscode/.config

# 開発開始コマンド
sudo ln -sf "$PWD/bin/work-meetlens" /usr/local/bin/work-meetlens

pipx install aws-sam-cli
# uvx は AWS MCP Server のプロキシ起動に使う
pipx install uv
# codex mcp-server を Claude Code から stdio で起動する
npm install -g @openai/codex

python -m venv backend/.venv
backend/.venv/bin/pip install -r backend/requirements.txt -r backend/requirements-dev.txt

(cd frontend && npm ci)
# E2E 用。@playwright/test のバージョンに合ったブラウザと OS 依存ライブラリを入れる
(cd frontend && npx playwright install --with-deps chromium)
