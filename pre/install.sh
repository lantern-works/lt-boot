# disable signature checks
sed -i -e "s/SigLevel    = Required DatabaseOptional/SigLevel = Never/g" /etc/pacman.conf

# upgrade pacman
yes | pacman -Syu --noconfirm

# install packages and auto-resolve dependencies
yes | pacman -Syy --noconfirm sudo 

# zsh grml-zsh-config ifplugd avahi bluez bluez-utils blueman

# we're going to use this downloaded software many times