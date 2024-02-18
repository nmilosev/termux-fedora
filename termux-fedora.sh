#!/data/data/com.termux/files/usr/bin/bash

# input validator and help

STARTFEDORA=/data/data/com.termux/files/usr/bin/fedora

case "$1" in
	f38)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/38/Container/aarch64/images/Fedora-Container-Base-38-1.6.aarch64.tar.xz
	    ;;
	f39)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/39/Container/aarch64/images/Fedora-Container-Base-39-1.5.aarch64.tar.xz
	    ;;
	uninstall)
	    chmod -R 777 ~/fedora
	    rm -rf ~/fedora
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

pkg install proot tar wget -y

# get the docker image

mkdir ~/fedora
cd ~/fedora
/data/data/com.termux/files/usr/bin/wget $DOCKERIMAGE -O fedora.tar.xz

# extract the Docker image

/data/data/com.termux/files/usr/bin/tar xvf fedora.tar.xz --strip-components=1 --exclude json --exclude VERSION

# extract the rootfs

/data/data/com.termux/files/usr/bin/tar xpf layer.tar

# cleanup

chmod +w .
rm layer.tar
rm fedora.tar.xz

# fix DNS

echo "nameserver 8.8.8.8" > ~/fedora/etc/resolv.conf

# make a shortcut

cat > $STARTFEDORA <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
unset LD_PRELOAD && proot --link2symlink -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w /root /bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/usr/bin:/usr/sbin /bin/bash --login
EOM

chmod +x $STARTFEDORA

# all done

echo "All done! Start Fedora with \'$(basename $STARTFEDORA)\'. Get updates with regular 'dnf update'."
