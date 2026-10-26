#!/bin/sh
export EARTHCRAFT_UPDATE_MODE=manual
# Prefer the host system's display-stack libraries over the bundled snapshot:
# linuxdeploy's GTK plugin cannot exclude them, and a bundled Wayland client
# that lags the host graphics drivers breaks Vulkan surface creation. Host
# directories are prepended so bundled copies remain a fallback for systems
# that lack them (multiarch layouts covered: Debian/Ubuntu, Fedora/RHEL, Arch).
for host_lib_dir in /usr/lib/x86_64-linux-gnu /usr/lib/aarch64-linux-gnu /usr/lib64 /usr/lib; do
    if [ -d "$host_lib_dir" ]; then
        if [ -n "$LD_LIBRARY_PATH" ]; then
            LD_LIBRARY_PATH="$host_lib_dir:$LD_LIBRARY_PATH"
        else
            LD_LIBRARY_PATH="$host_lib_dir"
        fi
    fi
done
export LD_LIBRARY_PATH
exec "$APPDIR/usr/bin/earthcraft" "$@"
