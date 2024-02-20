#!/data/data/com.termux/files/usr/bin/bash

TERMUX_BINDIR=/data/data/com.termux/files/usr/bin
STARTFEDORA=$TERMUX_BINDIR/fedora
TOPDIR=~/fedora

# input validator and help
case "$1" in
	f38)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/38/Container/aarch64/images/Fedora-Container-Base-38-1.6.aarch64.tar.xz
	    ;;
	f39)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/39/Container/aarch64/images/Fedora-Container-Base-39-1.5.aarch64.tar.xz
	    ;;
	uninstall)
	    chmod -R 777 $TOPDIR
	    rm -rf $TOPDIR
		rm -f $STARTFEDORA
	    exit 0
	    ;;
        https://*)
            DOCKERIMAGE=$1
	*)
	    echo $"Usage: $0 {f38|f39|TARURL|uninstall}"
	    exit 2
	    ;;
esac

# install necessary packages
pkg install proot tar wget make -y

if [ -d "$TOPDIR" ]; then
    echo $TOPDIR already exists
else
    mkdir $TOPDIR
    cd $TOPDIR
    # get the docker image
    $TERMUX_BINDIR/wget $DOCKERIMAGE -O fedora.tar.xz

    # extract the Docker image
    $TERMUX_BINDIR/tar xvf fedora.tar.xz --strip-components=1 --exclude json --exclude VERSION

    # extract the rootfs
    $TERMUX_BINDIR/tar xpf layer.tar

    # cleanup
    chmod +w .
    rm layer.tar
    rm fedora.tar.xz

    # fix DNS
    echo "nameserver 8.8.8.8" > $TOPDIR/etc/resolv.conf
fi

# make a shortcut
cp -p fedora $STARTFEDORA

# all done
echo "All done! Start Fedora with \'$(basename $STARTFEDORA)\'. Get updates with regular 'dnf update'."
