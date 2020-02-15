#!/bin/sh
dst=/dev/sdc1
dstd=/dev/sdc
dst_mount=/mnt/usb
newiso=/mnt/livefs
sudo syslinux -i $dst
sudo dd if=/usr/lib/syslinux/mbr/mbr.bin of=$dstd conv=notrunc bs=440 count=1
sudo mount $dst $dst_mount
#sudo cp /usr/lib/syslinux/menu.c32 $dst_mount/▫
#sudo cp /boot/memtest86+.bin $dst_mount/memtest▫
mkdir -p $dst_mount/syslinux
sudo cp $newiso/isolinux/isolinux.cfg $dst_mount/syslinux/syslinux.cfg
sudo cp $newiso/isolinux/*.cfg $dst_mount/syslinux/.
sudo cp $newiso/isolinux/*.cfg $dst_mount/.
sudo cp $newiso/isolinux/*.c32 $dst_mount/syslinux/.
sudo cp $newiso/isolinux/*.c32 $dst_mount/.
#sudo cp /usr/share/misc/pci.ids $dst_mount/▫
sudo rsync -rv $newiso/live $dst_mount/
