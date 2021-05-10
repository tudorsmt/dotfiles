#!/usr/bin/env bash

declare DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -e "${HOME}/.vim/colors/monokai.vim" ]; then
  mkdir -p "${HOME}/.vim/colors/"
  wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -O "${HOME}/.vim/colors/monokai.vim"\
else
  echo "Monokai theme already installed"
fi

if [ ! -e "${HOME}/.vim/pack/plugins/start/lightline" ]; then
  mkdir -p "${HOME}/.vim/pack/plugins/start/lightline"
  git clone https://github.com/itchyny/lightline.vim "${HOME}/.vim/pack/plugins/start/lightline"
else
  echo "Lightline already installed"
fi

ln -s "${DIR}/../.vimrc" "${HOME}/.vimrc"
