#!/system/bin/sh

# Wait until the system has finished booting if script cannot load please move manualy to service.d
(sys.boot_completed property equals 1)
while [ "$(getprop sys.boot_completed)" != "1" ]; do 
    sleep 5
done

#IO High Level 0 (Best balanced)
echo simple_ondemand > /sys/class/devfreq/mmc0/governor

echo 52000000 > /sys/class/mmc_host/mmc0/speed

#IO High Level 1 (Best balanced)
echo powersave > /sys/class/devfreq/mmc1/governor

echo 52000000 > /sys/class/mmc_host/mmc1/speed

# IO Optimization for Emmc kernel level mmclbk0 (Internal)

echo 1 > /sys/block/mmcblk0/queue/iosched/back_seek_penalty

echo 60 > /sys/block/mmcblk0/queue/iosched/fifo_expire_async

echo 25 > /sys/block/mmcblk0/queue/iosched/fifo_expire_sync

echo 1 > /sys/block/mmcblk0/queue/iosched/low_latency

echo 16 > /sys/block/mmcblk0/queue/iosched/quantum

echo 10 > /sys/block/mmcblk0/queue/iosched/slice_async

echo 1 > /sys/block/mmcblk0/queue/iosched/slice_async_rq

echo 0 > /sys/block/mmcblk0/queue/iosched/slice_idle

echo 0 > /sys/block/mmcblk0/queue/iosched/slice_sync_us

echo 80 > /sys/block/mmcblk0/queue/iosched/slice_sync

echo 50 > /sys/block/mmcblk0/queue/iosched/target_latency

echo 50000 > /sys/block/mmcblk0/queue/iosched/target_latency_us

# IO Optimization for Emmc kernel level SDA (USB Drive)
echo 1 > /sys/block/mmcblk1/queue/iosched/back_seek_penalty

echo 60 > /sys/block/mmcblk1/queue/iosched/fifo_expire_async

echo 25 > /sys/block/mmcblk1/queue/iosched/fifo_expire_sync

echo 1 > /sys/block/mmcblk1/queue/iosched/low_latency

echo 16 > /sys/block/mmcblk1/queue/iosched/quantum

echo 10 > /sys/block/mmcblk1/queue/iosched/slice_async

echo 1 > /sys/block/mmcblk1/queue/iosched/slice_async_rq

echo 0 > /sys/block/mmcblk1/queue/iosched/slice_idle

echo 0 > /sys/block/mmcblk1/queue/iosched/slice_sync_us

echo 80 > /sys/block/mmcblk1/queue/iosched/slice_sync

echo 50 > /sys/block/mmcblk1/queue/iosched/target_latency

echo 50000 > /sys/block/mmcblk1/queue/iosched/target_latency_us


# IO Optimization for Emmc kernel level mmclbk1 (MicroSD)
echo 1 > /sys/block/mmcblk1/queue/iosched/back_seek_penalty

echo 60 > /sys/block/mmcblk1/queue/iosched/fifo_expire_async

echo 25 > /sys/block/mmcblk1/queue/iosched/fifo_expire_sync

echo 1 > /sys/block/mmcblk1/queue/iosched/low_latency

echo 16 > /sys/block/mmcblk1/queue/iosched/quantum

echo 10 > /sys/block/mmcblk1/queue/iosched/slice_async

echo 1 > /sys/block/mmcblk1/queue/iosched/slice_async_rq

echo 0 > /sys/block/mmcblk1/queue/iosched/slice_idle

echo 0 > /sys/block/mmcblk1/queue/iosched/slice_sync_us

echo 80 > /sys/block/mmcblk1/queue/iosched/slice_sync

echo 50 > /sys/block/mmcblk1/queue/iosched/target_latency

echo 50000 > /sys/block/mmcblk1/queue/iosched/target_latency_us

#Resetprop
resetprop -n ro.boot.loglevel "0"
resetprop -n ro.debuggable "0"

# Kernel Edit (This can make bootloop if wrong settings)
echo 0 0 0 0 > /proc/sys/kernel/printk
echo 1  > /sys/touchpanel/double_tap
echo 0 > /proc/sys/net/ipv4/tcp_low_latency

# add Execute command with Superuser privileges. using kernel manager for late start services
su -c zsm -n
su -c sysctl -w kernel.dmesg_restrict=1
su -c dmesg -n 1
exit 0