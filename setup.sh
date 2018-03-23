#!/usr/bin/env bash

declare DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


setup() {
    _setup_zsh
    _setup_tmux
    _setup_i3
}

_setup_zsh () {
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        echo "oh-my-zsh installation not found at ${HOME}/.oh-my-zsh"
        echo "Please install oh-my-zsh from: https://github.com/robbyrussell/oh-my-zsh"
        exit 1
    fi

    declare zsh_config_dest="${HOME}/.zshrc"
    declare zsh_config="${DIR}/terminal/.zshrc"

    echo "Linking zsh config file"
    if [ ! -e "${zsh_config_dest}" ]; then
        ln -s "${zsh_config}" "${zsh_config_dest}"
    else
        echo "Found zsh config file ${zsh_config_dest}, will not create the override from ${zsh_config}"
    fi

    declare zsh_theme_dest="${HOME}/.oh-my-zsh/custom/themes/fishy_tdr.zsh-theme"
    declare zsh_theme="${DIR}/terminal/fishy_tdr.zsh-theme"
    echo "Linking zsh theme"
    if [ ! -e "${zsh_theme_dest}" ]; then
        mkdir -p "$(dirname "${zsh_theme_dest}")"
        ln -s "${zsh_theme}" "${zsh_theme_dest}"
    else
        echo "Found zsh theme file ${zsh_theme_dest}, will not create the override from ${zsh_theme}"
    fi
    echo
}

_setup_tmux() {
    declare -l tmux_config="${DIR}/terminal/.tmux.conf"
    declare -l tmux_config_dest="${HOME}/.tmux.conf"

    declare -l tmux_dir="${DIR}/terminal/.tmux"
    declare -l tmux_dir_dest="${HOME}/.tmux"

    echo "Linking tmux config file"
    if [ ! -e "${tmux_config_dest}" ]; then
        ln -s "${tmux_config}" "${tmux_config_dest}"
    else
        echo "Found tmux config file ${tmux_config_dest}, will not create the override from ${tmux_config}"
    fi

    echo "Linking tmux config directory"
    if [ ! -e "${tmux_dir_dest}" ]; then
        ln -s "${tmux_dir}" "${tmux_dir_dest}"
    else
        echo "Found tmux config directory ${tmux_dir_dest}, will not create the override from ${tmux_dir}"
    fi
    echo
}

_setup_i3() {
    declare -l screenlayout_dir="${DIR}/.screenlayout"
    declare -l screenlayout_dir_dest="${HOME}/.screenlayout"
    echo "Linking screenlayout directory"
    if [ ! -e "${screenlayout_dir_dest}" ]; then
        ln -s "${screenlayout_dir}" "${screenlayout_dir_dest}"
    else
        echo "Found screenlayout directory ${screenlayout_dir_dest}, will not create the override from ${screenlayout_dir}"
    fi

    declare -l i3_dir="${DIR}/i3"
    declare -l i3_dir_dest="${HOME}/.config/i3"
    echo "Linking i3 directory"
    if [ ! -e "${i3_dir_dest}" ]; then
        ln -s "${i3_dir}" "${i3_dir_dest}"
    else
        echo "Found i3 config directory ${i3_dir_dest}, will not create the override from ${i3_dir}"
    fi
    echo
}

setup
