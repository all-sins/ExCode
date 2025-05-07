#!/bin/bash

echo "====== CPU PERFORMANCE CHECK ======"
for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
  gov=$(cat "$cpu/cpufreq/scaling_governor")
  echo "${cpu##*/}: $gov"
done

echo -e "\n====== NVIDIA GPU PERFORMANCE CHECK ======"
nvidia-smi --query-gpu=name,persistence_mode,power.management,power.draw,power.limit,clocks.gr,clocks.mem,driver_model.current,utilization.gpu --format=csv,noheader,nounits

echo -e "\n====== NVIDIA Persistence Daemon ======"
systemctl is-active nvidia-persistenced

echo -e "\n====== NVIDIA Kernel Module Parameters ======"
modinfo nvidia | grep -Ei 'firmware|persistence|power|dpm|PerfLevelSrc' || echo "nvidia module not loaded."

echo -e "\n====== NVIDIA Driver in Xorg ======"
grep -i 'nvidia' /var/log/Xorg.0.log | grep -Ei 'driver|module|load'

echo -e "\n====== Kernel Boot Parameters ======"
cat /proc/cmdline

echo -e "\n====== PCIe Active State Power Management (ASPM) ======"
cat /sys/module/pcie_aspm/parameters/policy

echo -e "\n====== Suggested Improvements (if needed) ======"
echo "- CPU governors should all be 'performance'"
echo "- NVIDIA Perf should be P0 with persistence ON"
echo "- Kernel args should include: nvidia_drm.modeset=1 pcie_aspm=off"
echo "- Disable hybrid graphics if you're not using it (i915.modeset=0, nouveau.modeset=0)"

