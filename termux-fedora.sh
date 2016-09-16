# install necessary packages

apt install proot tar -y

# get the docker image

mkdir ~/fedora
cd ~/fedora
/data/data/com.termux/files/usr/bin/wget http://download.fedoraproject.org/pub/fedora/linux/releases/24/Docker/armhfp/images/Fedora-Docker-Base-24-1.2.armhfp.tar.xz

# extract the Docker image

/data/data/com.termux/files/usr/bin/tar xvf Fedora-Docker-Base-24-1.2.armhfp.tar.xz --strip-components=1 --exclude json --exclude VERSION

# extract the rootfs

/data/data/com.termux/files/usr/bin/tar xvpf layer.tar

# cleanup

chmod +w .
rm layer.tar
rm Fedora-Docker-Base-24-1.2.armhfp.tar.xz
rm json
rm VERSION

# make a shortcut

cat > /data/data/com.termux/files/usr/bin/fedora <<- EOM
#!/data/data/com.termux/usr/bin/sh
proot -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[root@f24 \W]\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:/bin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/fedora

# all done

echo "All done!, start Fedora with 'fedora'"
