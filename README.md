# dotfiles

個人用の dotfiles 設定。[chezmoi](https://www.chezmoi.io/) で管理。

## セットアップ

```bash
# chezmoi をインストール
brew install chezmoi

# dotfiles を取り込み
chezmoi init https://github.com/yourusername/dotfiles.git

# 設定を適用
chezmoi apply
```

## 採用ツール

### ターミナル
- **Ghostty** - 高速ターミナルエミュレータ
- **Moralerspace Neon** - Nerd Fonts 対応フォント（日本語・英語混在に最適）

### シェル・プロンプト
- **Zsh** - シェル
- **Starship** - プロンプト（ディレクトリフルパス表示）
- **Sheldon** - Zsh プラグインマネージャー
- **carapace** - マルチシェル対応補完システム

### ターミナルワークスペースマネージャー
- **herdr** - AI コーディングエージェント向けターミナルワークスペースマネージャー
  - Kanagawa テーマ
  - prefix キー: `Ctrl + a`
  - Vim ライクなペイン移動（`Ctrl + h/j/k/l`）

### バージョン管理・開発ツール
- **mise** - 開発ツールのバージョン管理
- **pyenv** - Python バージョン管理
- **tfenv** - Terraform バージョン管理
- **direnv** - ディレクトリ単位の環境変数管理

### リポジトリ・ Git 管理
- **ghq** - Git リポジトリ管理（`~/Documents/workspace` に統一管理）
- **lazygit** - Git TUI

### ファジーファインダー・検索
- **fzf** - ファジーファインダー（Vim スタイルキーバインド）
- **fd** - 高速ファイル検索
- **rg (ripgrep)** - 高速テキスト検索
- **bat** - syntax highlighting 付き cat

### エディタ

- **Neovim** (v0.11+, mise 管理) - テキストエディタ
  - Kanagawa テーマ
  - bufferline.nvim - バッファをタブ表示
  - nvim-tree - ファイルツリー
  - dropbar.nvim - パンくずリスト（ファイルパス・関数名）
  - telescope.nvim - ファジーファインダー
  - lualine.nvim - ステータスライン
  - Treesitter - 構文ハイライト
  - Mason + nvim-lspconfig - LSP（lua_ls）
  - dashboard-nvim - スタートスクリーン

### AI アシスタント
- **Claude Code** - Anthropic の CLI アシスタント
  - herdr でセッション永続化
  - カスタム statusLine（`~/.claude/statusline-command.sh`）
- **Cursor Agent CLI** - Cursor のターミナル Agent（`agent` コマンド）
  - Claude Code から**コピー**した設定（Claude 側は変更しない）
  - MCP: `~/.cursor/mcp.json`（`~/.claude/.mcp.json` と同内容）
  - Hooks: `~/.cursor/hooks.json`（Claude の Stop 通知相当）
  - CLI 設定: `~/.config/cursor/cli-config.json`（permissions / statusLine / notifications 等）
  - 確認待ち通知は Cursor の `notifications: true` が担当（Claude の permission_prompt hook 相当）

### その他のツール
- **ticker** - 株価・仮想通貨価格の TUI モニター

## 管理ファイル

- `.zshrc` - Zsh 設定
- `.gitconfig` - Git 設定（ghq root 設定含む）
- `.gitignore_global` - グローバル gitignore
- `.vimrc` - Vim 設定
- `.ideavimrc` - IntelliJ Vim 設定
- `.config/herdr/config.toml` - herdr 設定（テーマ・キーバインド）
- `.config/ghostty/config` - Ghostty ターミナル設定
- `.config/starship.toml` - Starship 設定
- `.config/sheldon/plugins.toml` - Sheldon プラグイン設定
- `.config/lazygit/config.yml` - lazygit 設定
- `.ticker.yaml` - ticker 設定
- `.stCommitMsg` - Git コミットテンプレート
- `.claude/settings.json` - Claude Code 設定
- `.claude/statusline-command.sh` - Claude Code statusLine スクリプト
- `.claude/scripts/notify.sh` - Claude Code 通知スクリプト
- `.cursor/statusline-command.sh` - Cursor Agent CLI statusLine スクリプト（Claude Code と同一）
- `.cursor/mcp.json` - Cursor Agent CLI MCP 設定（Claude の `.mcp.json` コピー）
- `.cursor/hooks.json` - Cursor Agent CLI hooks（Claude の Stop 通知相当）
- `.cursor/scripts/notify.sh` - Cursor Agent CLI 通知スクリプト（Claude と同一ロジック）
- `.config/cursor/agent-cli.fragment.json` - Cursor Agent CLI の permissions / notifications 等
- `.config/nvim/init.lua` - Neovim エントリーポイント
- `.config/nvim/lua/config/options.lua` - Neovim 基本設定
- `.config/nvim/lua/config/keymaps.lua` - グローバルキーバインド
- `.config/nvim/lua/plugins/ui.lua` - UI プラグイン（bufferline, dropbar, lualine 等）
- `.config/nvim/lua/plugins/editor.lua` - エディタプラグイン（nvim-tree, telescope 等）
- `.config/nvim/lua/plugins/coding.lua` - コーディングプラグイン（treesitter, mini.pairs 等）
- `.config/nvim/lua/plugins/lsp.lua` - LSP 設定（Mason, nvim-lspconfig）

## キーバインド

### herdr

| キー | 機能 |
|------|------|
| `prefix + "` | 水平分割 |
| `prefix + %` | 垂直分割 |
| `prefix + k` / `prefix + j` | ワークスペース移動（上/下） |
| `Ctrl + h/j/k/l` | ペイン移動（左/下/上/右） |

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

### zsh エイリアス

| コマンド | 機能 |
|---------|------|
| `gc` | ghq リポジトリを fzf で選択して cd |
| `gg <URL>` | ghq get（リポジトリをクローン） |

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
