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

### ターミナルマルチプレクサ
- **tmux** - ターミナルマルチプレクサ
  - Kanagawa テーマ (Nybkox/tmux-kanagawa)
  - TPM (Tmux Plugin Manager)
  - CPU/RAM 使用率、時間表示
  - Vim ライクなペイン選択
  - Popup window 機能（lazygit、fzf、セッション選択、ghq 連携）

### バージョン管理・開発ツール
- **mise** - 開発ツールのバージョン管理
- **pyenv** - Python バージョン管理
- **tfenv** - Terraform バージョン管理
- **direnv** - ディレクトリ単位の環境変数管理

### リポジトリ・ Git 管理
- **ghq** - Git リポジトリ管理（`~/Documents/workspace` に統一管理）
- **lazygit** - Git TUI（tmux popup で起動可能）

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
  - tmux popup でセッション永続化
  - OSC 9 デスクトップ通知（Ghostty 連携）

### その他のツール
- **ticker** - 株価・仮想通貨価格の TUI モニター

## 管理ファイル

- `.zshrc` - Zsh 設定
- `.gitconfig` - Git 設定（ghq root 設定含む）
- `.gitignore_global` - グローバル gitignore
- `.vimrc` - Vim 設定
- `.ideavimrc` - IntelliJ Vim 設定
- `.tmux.conf` - tmux 設定（popup window キーバインド含む）
- `.config/ghostty/config` - Ghostty ターミナル設定
- `.config/starship.toml` - Starship 設定
- `.config/sheldon/plugins.toml` - Sheldon プラグイン設定
- `.config/lazygit/config.yml` - lazygit 設定
- `.ticker.yaml` - ticker 設定
- `.stCommitMsg` - Git コミットテンプレート
- `.local/bin/tmux-session-picker` - tmux セッション選択スクリプト
- `.claude/settings.json` - Claude Code 設定
- `.claude/scripts/notify.sh` - Claude Code 通知スクリプト（OSC 9）
- `.config/nvim/init.lua` - Neovim エントリーポイント
- `.config/nvim/lua/config/options.lua` - Neovim 基本設定
- `.config/nvim/lua/config/keymaps.lua` - グローバルキーバインド
- `.config/nvim/lua/plugins/ui.lua` - UI プラグイン（bufferline, dropbar, lualine 等）
- `.config/nvim/lua/plugins/editor.lua` - エディタプラグイン（nvim-tree, telescope 等）
- `.config/nvim/lua/plugins/coding.lua` - コーディングプラグイン（treesitter, mini.pairs 等）
- `.config/nvim/lua/plugins/lsp.lua` - LSP 設定（Mason, nvim-lspconfig）

## キーバインド

### tmux popup window

| キー | 機能 |
|------|------|
| `prefix + g` | lazygit を popup で起動 |
| `prefix + f` | fzf でファイル検索・プレビュー |
| `prefix + t` | popup シェル（セッション永続化、ログインシェル） |
| `prefix + D` | popup セッションを削除 |
| `prefix + s` | fzf でセッション選択（ペイン内容プレビュー付き） |
| `prefix + p` | ghq リポジトリを選択して cd |
| `prefix + m` | man ページを popup で表示 |
| `prefix + y` | Claude Code を popup で起動（セッション永続化） |
| `prefix + Y` | Claude Code セッションを終了 |

### Neovim

`<leader>` キー = `Space`

#### ファイル操作

| キー | 機能 |
|------|------|
| `<C-n>` | ファイルツリー 表示/非表示 |
| `<CR>` / `l` | ファイルを現在ウィンドウで開く |
| `<Space>` | ファイルをプレビュー（tree フォーカス維持） |
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

### tmux ペイン操作

| キー | 機能 |
|------|------|
| `Option + 0〜4` | ペイン番号でジャンプ（prefix なし） |
| `prefix + h/j/k/l` | Vim ライクなペイン移動 |
| `prefix + H/J/K/L` | ペインリサイズ |

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
