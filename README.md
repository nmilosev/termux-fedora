# termux-fedora
A script to install a Fedora chroot into Termux.

Currently it supports Fedora 27 ARM/ARM64, Fedora 28 ARM64 and Fedora 29 Beta ARM64.

Starting from Fedora 28, Container image for 32bit ARM is no longer provided.

# Alternative

You can also try running https://github.com/nmilosev/anyfed which is a bit more versatile in creating chroot's.

# Instructions

Supported images:

- f27_arm
- f27_arm64
- f28_arm64
- f29_arm64

```
pkg install wget -y && /data/data/com.termux/files/usr/bin/wget https://raw.githubusercontent.com/nmilosev/termux-fedora/master/termux-fedora.sh

sh termux-fedora.sh [desired image]
```

For example:

```
sh termux-fedora.sh f29_arm64
```

To uninstall:

```
sh termux-fedora.sh uninstall
```

https://nmilosev.svbtle.com/termuxfedora-install-fedora-on-your-phone-with-termux
