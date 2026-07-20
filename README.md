# dotfiles

個人用の dotfiles 設定。[chezmoi](https://www.chezmoi.io/) で管理。

## セットアップ

```bash
# chezmoi をインストール
brew install chezmoi

# dotfiles を取り込み
chezmoi init https://github.com/dkajiwara/dotfiles.git

# 設定を適用
chezmoi apply
```

## 管理方針

### 部分管理する設定（Claude / Cursor）

`~/.claude/settings.json` と `~/.config/cursor/cli-config.json` は、エージェント自身が実行時に書き込むキーがあるため、ファイル全体ではなく一部だけを [`modify_` スクリプト](https://www.chezmoi.io/reference/target-types/#modify_-scripts)で管理しています（`chezmoi apply` のたびに実機の内容を標準入力で受け取り、管理対象のキーだけを上書きして出力）。

- **Claude**: `enabledPlugins`・`advisorModel`（`/config` やプラグイン管理で書き換わる）は実機の値のまま素通りし、それ以外（`permissions`・`hooks`・`statusLine` 等）を管理
- **Cursor**: `version`・`editor`（Cursor 自身が書き込む）は実機の値のまま素通りし、それ以外（`permissions`・`statusLine`・`notifications`・`attribution`）を管理
- `modify_` を選んでいるのは、`chezmoi apply` のたびに実機の現在値とマージでき、管理対象キーの外部変更もきちんと検知されるため

## 管理対象

### ターミナル・シェル

- **Ghostty** - ターミナルエミュレータ（フォント: Moralerspace Neon）
- **Zsh** + **Starship** + **Sheldon**（プラグイン管理）+ **carapace**（補完）
- **herdr** - AI コーディングエージェント向けターミナルワークスペースマネージャー
  - Kanagawa テーマ、prefix キー `Ctrl + a`
  - `[ui.toast]`（`delivery = "terminal"`）で、バックグラウンドのエージェントが完了・入力待ちになったときに Ghostty (`desktop-notifications = true`) 経由でデスクトップ通知。SSH 越しの herdr セッションでも有効。herdr 管理外のターミナルでは通知は出ない
  - Claude Code・Cursor Agent CLI 側の完了・確認待ち通知はこの `[ui.toast]` が担当（各エージェント側の hook は使わない）
- **mise** / **pyenv** / **tfenv** / **direnv** / **zoxide** - `.zshrc` で有効化（バージョン固定などの個別設定はこのリポジトリでは管理していない）

### Git・開発ツール

- **ghq**（`~/Documents/workspace` に統一管理）+ **lazygit**（Git TUI）+ **tig**
- **fzf**（ファジーファインダー）/ **fd** / **rg (ripgrep)** / **bat**

### エディタ

- **Neovim** - Mason + nvim-lspconfig（LSP: `lua_ls`, `ts_ls`）
  - Kanagawa テーマ、bufferline.nvim、nvim-tree、dropbar.nvim、telescope.nvim、lualine.nvim、Treesitter、dashboard-nvim

### AI エージェント

- **Claude Code** - Anthropic の CLI アシスタント。herdr でセッション永続化、カスタム statusLine
- **Cursor Agent CLI** - Cursor のターミナル Agent（`agent` コマンド）。Claude Code と同じ表示ロジックの statusLine、Cursor 専用の MCP 設定（`~/.claude/.mcp.json` は chezmoi 管理外の別リポジトリへのシンボリックリンクで、自動連携はない）

## 管理ファイル

主なディレクトリ単位の管理対象です。個別に注意が必要なもの（部分管理・シンボリックリンクなど）のみ個別記載しています。

- `~/.zshrc`, `~/.gitconfig`, `~/.gitignore_global`, `~/.ideavimrc`, `~/.tigrc`, `~/.stCommitMsg`
- `~/.config/herdr/`, `~/.config/ghostty/`, `~/.config/starship.toml`, `~/.config/sheldon/`, `~/.config/lazygit/`
- `~/.config/nvim/` - Neovim 設定（init.lua、config/options・keymaps、plugins/ui・editor・coding・lsp・init）
- `~/.claude/CLAUDE.md`, `~/.claude/statusline-command.sh`
- `~/.claude/settings.json` - `modify_`（[管理方針](#部分管理する設定claude--cursor)参照）
- `~/.cursor/statusline-command.sh`, `~/.cursor/mcp.json`
- `~/.config/cursor/cli-config.json` - `modify_`（[管理方針](#部分管理する設定claude--cursor)参照）

## キーバインド・コマンド

### herdr

| キー | 機能 |
|------|------|
| `prefix + "` | 水平分割 |
| `prefix + %` | 垂直分割 |
| `prefix + k` / `prefix + j` | ワークスペース移動（上/下） |
| `Ctrl + h/j/k/l` | ペイン移動（左/下/上/右） |
| `prefix + g` | lazygit を popup で起動 |
| `prefix + t` | scratch shell を popup で起動 |

### Neovim

`<leader>` キー = `Space`

#### ファイル操作

| キー | 機能 |
|------|------|
| `<C-n>` | ファイルツリー 表示/非表示 |
| `<CR>` / `l` | ファイルを現在ウィンドウで開く |
| `<Tab>` | ファイルをプレビュー（tree フォーカス維持） |
| `h` | ディレクトリを閉じる |

#### バッファ管理（bufferline）

| キー | 機能 |
|------|------|
| `<Tab>` | 次のバッファへ |
| `<S-Tab>` | 前のバッファへ |
| `<leader>bd` | 現在のバッファを閉じる |

#### パンくずリスト（dropbar）

| キー | 機能 |
|------|------|
| `<leader>;` | ドロップダウンでシンボル選択 |
| `[;` | 現在のコンテキストの先頭へ |
| `];` | 次のコンテキストへ |

#### Telescope（ファジーファインダー）

| キー | 機能 |
|------|------|
| `<leader>ff` | ファイル検索 |
| `<leader>fr` | 最近開いたファイル |
| `<leader>fg` | テキスト全文検索（Live Grep） |

#### その他

| キー | 機能 |
|------|------|
| `jj` | Insert → Normal モード |

### zsh コマンド

| コマンド | 機能 |
|---------|------|
| `gc` | ghq リポジトリを fzf で選択して cd |
| `gg <URL>` | ghq get（リポジトリをクローン） |
| `agent -c` | Cursor Agent CLI を `--continue` 付きで起動（`claude -c` 相当） |
| `cmini2 [dir]` | macmini2.local に SSH 接続し、指定ディレクトリで Claude Code を起動（herdr へのエージェント状態報告付き） |
| `wt` | git worktree を fzf で選択して cd |

### fzf

| キー | 動作 |
|------|------|
| `Ctrl + j` | 下に移動 |
| `Ctrl + k` | 上に移動 |
| `Ctrl + d` | 半ページ下 |
| `Ctrl + u` | 半ページ上 |

## 更新

```bash
# 設定ファイルを編集
chezmoi edit ~/.zshrc

# 変更を適用
chezmoi apply

# リポジトリに反映
cd ~/.local/share/chezmoi
git add .
git commit -m "Update"
git push
```
