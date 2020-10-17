#!/bin/bash

DOT_DIRECTORY="${HOME}/dotfiles"

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
