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

## 管理ファイル

- `.zshrc` - Zsh 設定
- `.gitconfig` - Git 設定
- `.gitignore_global` - グローバル gitignore
- `.vimrc` - Vim 設定
- `.ideavimrc` - IntelliJ Vim 設定
- `.tmux.conf` - tmux 設定
- `.stCommitMsg` - Git コミットテンプレート

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
