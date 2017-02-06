# termux-fedora
A script to install a Fedora chroot into Termux.

Currently it supports Fedora 24 ARM32, Fedora 25 Beta ARM32/ARM64

# Alternative

You can also try running https://github.com/nmilosev/anyfed which is a bit more versatile in creating chroot's.

# Instructions

Supported images:

- f25_arm
- f25_arm64

```
apt update && apt install wget -y && /data/data/com.termux/files/usr/bin/wget https://raw.githubusercontent.com/nmilosev/termux-fedora/master/termux-fedora.sh

sh termux-fedora.sh [desired image]
```

For example:

```
sh termux-fedora.sh f25beta_arm64
```

To uninstall:

```
sh termux-fedora.sh uninstall
```

https://nmilosev.svbtle.com/termuxfedora-install-fedora-on-your-phone-with-termux
