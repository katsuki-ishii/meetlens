FROM mcr.microsoft.com/devcontainers/python:1-3.13-bookworm

# ベースイメージ同梱の yarn apt リポジトリは署名鍵が失効しており、
# apt-get update が失敗して features のインストールが止まるため削除する
RUN rm -f /etc/apt/sources.list.d/yarn.list

# Claude Code にクリップボードの画像を Ctrl+V で貼り付けるため（wl-paste を使う）。
# VS Code が用意する Wayland ソケット経由で Windows のクリップボードを読む
RUN apt-get update \
    && apt-get install -y --no-install-recommends wl-clipboard \
    && rm -rf /var/lib/apt/lists/*
