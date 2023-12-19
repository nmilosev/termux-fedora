#!/data/data/com.termux/files/usr/bin/bash

# input validator and help

# https://github.com/fedorapackaging/docker-images

case "$1" in
	f39)
	    DOCKERIMAGE=https://mirror.init7.net/fedora/fedora/linux/releases/39/Container/aarch64/images/Fedora-Container-Minimal-Base-39-1.5.aarch64.tar.xz
	    ;;
	uninstall)
	    chmod -R 777 ~/fedora
	    rm -rf ~/fedora
		rm -f /data/data/com.termux/files/usr/bin/startfedora
	    exit 0
	    ;;
	*)
	    echo $"Usage: $0 {f37|f38|uninstall}"
	    exit 2
	    ;;
esac


# install necessary packages

pkg install proot tar wget -y

# get the docker image

mkdir -p ~/fedora
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
mkdir -p ~/fedora/etc/systemd/resolved.conf.d/
echo "DNS=185.95.218.42 185.95.218.43" > ~/fedora/etc/systemd/resolved.conf.d/DNS-Overwrite.conf
echo "FallbackDNS=78.46.244.143 45.91.92.121" >> ~/fedora/etc/systemd/resolved.conf.d/DNS-Overwrite.conf

# make a shortcut

cat > /data/data/com.termux/files/usr/bin/startfedora <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
unset LD_PRELOAD && proot --link2symlink -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@fedora \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/startfedora

# all done

echo "All done! Start Fedora with 'startfedora'. Get updates with regular 'dnf update'. "
