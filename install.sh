#!/bin/bash

DOT_DIRECTORY="${HOME}/dotfiles"

cd `dirname $0`

echo "Create dotfile links."

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == "README.md" ]] && continue
    [[ "$f" == "install.sh" ]] && continue

    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)

echo "brew bundle --global y/n"
read answer
case "$answer" in
  "y")
    brew bundle --global
    break ;;
  *)
    echo 'Finish!'
    exit 1;;
esac
