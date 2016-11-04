# termux-fedora
A script to install a Fedora chroot into Termux.

Currently it supports Fedora 24 ARM32, Fedora 25 Beta ARM32/ARM64

# Instructions

Supported images:

- f24_arm
- f25beta_arm
- f25beta_arm64


```
apt update && apt install wget -y && /data/data/com.termux/files/usr/bin/wget https://raw.githubusercontent.com/nmilosev/termux-fedora/master/termux-fedora.sh

sh termux-fedora.sh [desired image]

# for example:

sh termux-fedora.sh f25beta_arm64

```

or

https://nmilosev.svbtle.com/termuxfedora-install-fedora-on-your-phone-with-termux
