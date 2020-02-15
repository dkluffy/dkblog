#install syslinux (bootloader)
#Copy files necessary for the USB to boot and copy the environment to the USB drive (I am assuming you have an umounted FAT32 formatted USB drive /dev/sdf and the BOOT flag is set on /dev/sdf1 and you have a ready mount point at /mnt/usb)
#extlinux v6.00+ [6.03+] FAT12/16/32, NTFS, ext2/3/4, Btrfs, XFS, UFS/FFS,
sudo syslinux -i /dev/sdf1
sudo dd if=/usr/lib/syslinux/mbr.bin of=/dev/sdf conv=notrunc bs=440 count=1
sudo mount /dev/sdf1 /mnt/usb
#sudo cp /usr/lib/syslinux/menu.c32 /mnt/usb/ 
#sudo cp /boot/memtest86+.bin /mnt/usb/memtest 
sudo cp newiso/isolinux/isolinux.cfg /mnt/usb/syslinux.cfg
sudo cp newiso/isolinux/*.cfg /mnt/usb/.
sudo cp newiso/isolinux/*.c32 /mnt/usb/.
#sudo cp /usr/share/misc/pci.ids /mnt/usb/
sudo rsync -rv image/live /mnt/usb/

#------modify way 1-------------
#kali 2.0 works, persistence works
mkdir -p newiso
cp kali.iso/*  newiso/.

#modify
unsquashfs /mnt/kaliiso/live/filesystem.squashfs /mnt/kalifs
#or
mount -o loop /mnt/kaliiso/live/filesystem.squashfs /mnt/kalifs
mksquashfs $BASE filesystem.squashfs -e boot
#genisoimage -rational-rock -volid "KaliLive" -cache-inodes -joliet -full-iso9660-filenames -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -output kali-linux.iso /mnt/newiso

#-------modify way 2---------------------
basedir=/data/myiso
livecd=/mnt/usb
cd $basedir
mkdir -p custom
mkdir -p union
mkdir -p /mnt/livefs
mount $livecd/live/filesystem.squashfs /mnt/livefs    
unionfs-fuse -o cow,max_files=32768 -o allow_other,use_ino,suid,dev,nonempty $basedir/custom=RW:/mnt/livefs=RO $basedir/union/
cd union
mount -o bind /proc proc/ 
chroot .


cd /tmp
mksquashfs custom/ custom.squashfs
cp custom.squashfs /path/to/live/




#persistence for kali
mkfs.ext3 -L persistence /dev/sdc3
e2label /dev/sdc3 persistence

mkdir -p /mnt/my_usb
mount /dev/sdc3 /mnt/my_usb
echo "/ union" > /mnt/my_usb/persistence.conf
umount /dev/sdc3


#---note for thunder xware----
mkdir -p /mnt/sharep && mount -o username=dk,nolock //172.168.1.251/public /mnt/sharep/
