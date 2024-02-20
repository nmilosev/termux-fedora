# termux-fedora
A script to install a Fedora chroot into Termux.

Currently it supports Fedora 38 & 39 ARM64.

Supported images:
- f38 aarch64
- f39 aarch64

or any fedora container tarball url.

# Instructions

In Termux run:
```
$ pkg install git
$ git clone git://github.com/juhp/termux-fedora
$ termux-fedora/install.sh [f38|f39|URL]
$ fedora
```

To uninstall:
```
$ ./termux-fedora.sh uninstall
```

Original blog post:
https://nmilosev.svbtle.com/termuxfedora-install-fedora-on-your-phone-with-termux
