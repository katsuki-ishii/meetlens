FROM mcr.microsoft.com/devcontainers/python:1-3.13-bookworm

# ベースイメージ同梱の yarn apt リポジトリは署名鍵が失効しており、
# apt-get update が失敗して features のインストールが止まるため削除する
RUN rm -f /etc/apt/sources.list.d/yarn.list
