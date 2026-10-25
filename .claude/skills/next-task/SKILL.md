---
name: next-task
description: MeetLens の GitHub Projects（カンバン）・Issue・git の状態を確認し、今日取り組むタスクの優先順位と最初の一歩を提案する。作業開始時や「次に何をする？」と聞かれたときに使う。
---

# 次に取り組むタスクの提案

作業開始時に、現状を把握して今日やることを提案する。**提案までが役割**であり、Issue のステータス変更や作業への着手は、開発者が選んでから行う。

## 1. 現状を集める

以下を実行して情報を集める（`gh` が未ログインなら、`gh auth login` を案内して止める）。

```bash
# カンバン（進捗の正）。Done 以外のステータスとフェーズラベルを確認する
gh project item-list 1 --owner katsuki-ishii --limit 100 --format json \
  -q '.items[] | select(.status != "Done") | "#\(.content.number) [\(.status)] [\(.labels // [] | join(","))] \(.title)"'

# 作業途中の変更・未 push のコミット
git status -sb
git log --oneline -5
```

In Progress の Issue は `gh issue view <番号>` で本文（チェックリスト）を読み、残りのサブタスクを把握する。

## 2. 優先順位をつける

次の順で考える。

1. **やりかけのもの**: 未コミットの変更、未 push のコミット、In Progress の Issue の残りサブタスク
2. **フェーズの順序**: ラベル `Phase 0` → `Phase 1` → `Phase 2` → `Phase 3` の順に、前のフェーズの残りを優先する
3. **依存関係**: 他のタスクの前提になるもの（例: 仕様が実装の前提）を先にする
4. **任意のタスク**: Issue に「任意」とあるものは最後に回す

## 3. 提案する

以下の形式で、日本語で簡潔に答える。

- **現状**: 進行中の Issue と、やりかけの作業（あれば）を 2〜3 行で
- **今日のおすすめ**: 1 つ（Issue 番号、理由、最初にやること）
- **ほかの候補**: 2〜3 個（Issue 番号と一言の理由）

最後に「どれから始めますか？」と聞いて止まる。開発者が選んだら、CLAUDE.md のタスク管理ルールに従って Issue を In Progress にしてから着手する。
