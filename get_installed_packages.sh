
YAY='pkgs/yay.txt'
PCMN='pkgs/pacman.txt'

sudo pacman -Qem | awk '{print $1}' > ${YAY}
sudo pacman -Qen | awk '{print $1}' > ${PCMN};

#join -v1 -v2 <(sort ${PCMN}) <(sort ${YAY}) > ${PCMN}
