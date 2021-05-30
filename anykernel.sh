# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Soviet kernel NATO66613 @ xda-developers
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=1
device.name1=raphael
device.name2=raphaelin
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
no_block_display=true;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## begin vendor changes
mount -o rw,remount -t auto /vendor >/dev/null;

# Make a backup of init.target.rc
restore_file /vendor/etc/init/hw/init.target.rc;

## AnyKernel install
dump_boot;

# Clean up other kernels' ramdisk overlay files
rm -rf $ramdisk/overlay;
rm -rf $ramdisk/overlay.d;

# begin ramdisk changes
if [ -d $ramdisk/.backup ]; then
	mv /tmp/anykernel/overlay.d $ramdisk/overlay.d
	chmod -R 750 $ramdisk/overlay.d/*
	chown -R root:root $ramdisk/overlay.d/*
	chmod -R 755 $ramdisk/overlay.d/sbin/init.soviet.sh
	chown -R root:root $ramdisk/overlay.d/sbin/init.soviet.sh
fi;

write_boot;
## end install

