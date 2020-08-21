#!/system/bin/sh 

sleep 30;

# Applying Soviet Settings

# Tune for WALT
	echo 15 > /proc/sys/kernel/sched_group_downmigrate
	echo 400000000 > /proc/sys/kernel/sched_coloc_downmigrate_ns
	echo 30 > /proc/sys/kernel/sched_min_task_util_for_colocation

# Tweak IO performance after boot complete
	echo "cfq" > /sys/block/sda/queue/scheduler
	echo 128 > /sys/block/sda/queue/read_ahead_kb
	echo 128 > /sys/block/dm-0/queue/read_ahead_kb

# Input boost and stune configuration
	echo "0:1382400" > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 500 > /sys/module/cpu_boost/parameters/input_boost_ms

# Set min cpu freq
	echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 710400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 825600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq

# configure governor settings for silver cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 1209600 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	echo 576000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl

# configure governor settings for gold cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl

# configure governor settings for gold+ cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl

# Setup EAS cpusets values for better load balancing
	echo 0-7 > /dev/cpuset/top-app/cpus
	echo 0-7 > /dev/cpuset/foreground/cpus
	echo 0-3 > /dev/cpuset/background/cpus
	echo 0-3 > /dev/cpuset/system-background/cpus
	echo 0-3 > /dev/cpuset/restricted/cpus

# Tune FS
	echo 3000 > /proc/sys/vm/dirty_expire_centisecs
	echo 10 > /proc/sys/vm/dirty_background_ratio

# Setup runtime blkio
# value for group_idle is us
	echo 1000 > /dev/blkio/blkio.weight
	echo 200 > /dev/blkio/background/blkio.weight
	echo 2000 > /dev/blkio/blkio.group_idle
	echo 0 > /dev/blkio/background/blkio.group_idle

sleep 15;

echo "Soviet Boot Completed" >> /dev/kmsg
