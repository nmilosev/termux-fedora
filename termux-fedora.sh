#!/data/data/com.termux/files/usr/bin/bash

# input validator and help

case "$1" in
	f29_arm64)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/29/Container/aarch64/images/Fedora-Container-Base-29-1.2.aarch64.tar.xz
	    ;;
        f30_arm64)
	    DOCKERIMAGE=https://download.fedoraproject.org/pub/fedora/linux/releases/30/Container/aarch64/images/Fedora-Container-Base-30-1.2.aarch64.tar.xz
	    ;;
	uninstall)
	    chmod -R 777 ~/fedora
	    rm -rf ~/fedora
	    exit 0
	    ;;
	*)
	    echo $"Usage: $0 {f29_arm64|f30_arm64|uninstall}"
	    exit 2
	    ;;
esac


# install necessary packages

pkg install proot tar -y

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

cat > /data/data/com.termux/files/usr/bin/startfedora <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
unset LD_PRELOAD && proot --link2symlink -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@fedora \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/startfedora

# all done

echo "All done! Start Fedora with 'startfedora'. Get updates with regular 'dnf update'. "
