#!/usr/bin/bash

paru='pkgs/paru.txt'
pacman='pkgs/pacman.txt'
flatpak='pkgs/flatpak.txt'

mapfile -t paru_pkgs < <(sudo paru -Qem | awk '{print $1}')
mapfile -t pacman_pkgs < <(sudo pacman -Qen | awk '{print $1}')
mapfile -t flatpak_pkgs < <(flatpak list --app --columns=application)

printf '%s\n' "${paru_pkgs[@]}" > $paru
printf '%s\n' "${pacman_pkgs[@]}" > $pacman
printf '%s\n' "${flatpak_pkgs[@]}" > $flatpak
