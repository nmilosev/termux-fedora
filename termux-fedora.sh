#!/data/data/com.termux/files/usr/bin/bash

# input validator and help

case "$1" in
	f24_arm)
	    DOCKERIMAGE=http://download.fedoraproject.org/pub/fedora/linux/releases/24/Docker/armhfp/images/Fedora-Docker-Base-24-1.2.armhfp.tar.xz
	    ;;
	f25beta_arm)
	    DOCKERIMAGE=http://dl.fedoraproject.org/pub/fedora/linux/releases/test/25_Beta/Docker/armhfp/images/Fedora-Docker-Base-25_Beta-1.1.armhfp.tar.xz
	f24_arm64)
	    DOCKERIMAGE=https://dl.fedoraproject.org/pub/fedora-secondary/releases/24/Docker/aarch64/images/Fedora-Docker-Base-24-1.1.aarch64.tar.xz
            ;;
	f25beta_arm64)
	    DOCKERIMAGE=http://dl.fedoraproject.org/pub/fedora-secondary/releases/test/25_Beta/Docker/aarch64/images/Fedora-Docker-Base-25_Beta-1.2.aarch64.tar.xz
	    ;;
	uninstall)
	    rm -rf ~/fedora
	    exit 0
            ;;
	*)
	    echo $"Usage: $0 {f24_arm|f25beta_arm|f24_arm64|f25beta_arm64|uninstall}"
	    exit 2
esac


# install necessary packages

apt update && apt install proot tar -y

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
proot -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@fedora \W]\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/startfedora

# all done

echo "All done! Start Fedora with 'startfedora'. Gets update with regular 'dnf update'. "
