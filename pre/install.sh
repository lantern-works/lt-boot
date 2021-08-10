# disable signature checks
sed -i -e "s/SigLevel    = Required DatabaseOptional/SigLevel = Never/g" /etc/pacman.conf

# upgrade pacman
yes | pacman -Syu --noconfirm

# install packages and auto-resolve dependencies
yes | pacman -Syy --noconfirm sudo 


# install useful core packages
pacman -Sy --needed --noconfirm git zsh grml-zsh-config ifplugdsudo nano npm python

# install network-related packages
pacman -Sy --noconfirm --needed dnsmasq nss-mdns avahi

# we're going to use this downloaded software many times