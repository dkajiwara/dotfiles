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

## キーバインド

### tmux popup window

| キー | 機能 |
|------|------|
| `prefix + g` | lazygit を popup で起動 |
| `prefix + f` | fzf でファイル検索・プレビュー |
| `prefix + t` | popup シェル（セッション永続化） |
| `prefix + s` | fzf でセッション選択 |
| `prefix + p` | ghq リポジトリを選択して cd |
| `prefix + m` | man ページを popup で表示 |

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
