#!/data/data/com.termux/files/usr/bin/bash

TERMUX_BINDIR=/data/data/com.termux/files/usr/bin
STARTFEDORA=$TERMUX_BINDIR/fedora
FEDORA=~/fedora
CWD=$PWD

# input validator and help
case "$1" in
	f38)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/38/Container/aarch64/images/Fedora-Container-Base-38-1.6.aarch64.tar.xz
	    ;;
	f39)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/39/Container/aarch64/images/Fedora-Container-Base-39-1.5.aarch64.tar.xz
	    ;;
	uninstall)
	    chmod -R 777 $FEDORA
	    rm -rf $FEDORA
		rm -f $STARTFEDORA
	    exit 0
	    ;;
        https://*)
            DOCKERIMAGE=$1
            ;;
        script)
            ;;
	*)
	    echo $"Usage: $0 {f38|f39|TARURL|uninstall}"
	    exit 2
	    ;;
esac

if [ "$1" = "script" ]; then
    echo "updating 'fedora' script"
elif [ -d "$FEDORA" ]; then
    if [ "$FEDORA" = "$HOME/fedora" ]; then
        fedora='~/fedora'
    else
        fedora=$FEDORA
    fi
    echo "$fedora exists"
    exit 1
else
    # install necessary packages
    pkg install proot tar wget -y

    mkdir $FEDORA
    cd $FEDORA
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
    echo "nameserver 8.8.8.8" > etc/resolv.conf

    echo "installing 'fedora' script"
fi

# make a shortcut
TOP=$(dirname "$0")
cp $CWD/$TOP/fedora $STARTFEDORA
chmod +x $STARTFEDORA

# all done
echo "done"

if [ "$1" != "script" -a "$1" != "uninstall" ]; then
    echo "Start Fedora with '$(basename $STARTFEDORA)'. Get updates with regular 'dnf update'."
fi
