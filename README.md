# termux-fedora
A script to install a Fedora chroot into Termux.

Currently it supports Fedora 38 ARM64 and Fedora 39 ARM64.

# Instructions

Supported aarch64 images:

- f38 aarch64
- f39 aarch64
- any fedora container tarball url

```
pkg install wget -y && /data/data/com.termux/files/usr/bin/wget https://raw.githubusercontent.com/nmilosev/termux-fedora/master/termux-fedora.sh

sh termux-fedora.sh [desired image]
```

For example:

```
sh termux-fedora.sh f39
```

To uninstall:

```
sh termux-fedora.sh uninstall
```

https://nmilosev.svbtle.com/termuxfedora-install-fedora-on-your-phone-with-termux
