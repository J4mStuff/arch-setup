#!/usr/bin/bash

paru='pkgs/paru.txt'
pacman='pkgs/pacman.txt'

#paru_pkgs=($(sudo paru -Qem | awk '{print $1}'))
mapfile -t paru_pkgs < <(sudo paru -Qem | awk '{print $1}')
mapfile -t pacman_pkgs < <(sudo pacman -Qen | awk '{print $1}')

printf '%s\n' "${paru_pkgs[@]}"
printf '%s\n' "${paru_pkgs[@]}" > $paru

printf "\n\n\n"

printf '%s\n' "${pacman_pkgs[@]}"
printf '%s\n' "${pacman_pkgs[@]}" > $pacman
