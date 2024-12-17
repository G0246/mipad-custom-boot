#!/system/bin/sh

MODDIR=${0%/*}

# Check if the boot animation path exists
if [ -f /system/media/bootanimation.zip ]; then
    BootAnimPath=$MODDIR/system/media
else
    exit 1
fi

# Change to the boot animation path
cd "$BootAnimPath" || exit 1

boot_animations=(
    "bootanimation.zip"
    "bootanimation01.zip"
    "bootanimation02.zip"
    "bootanimation03.zip"
    "bootanimation04.zip"
)

# Copy files
for file in "${boot_animations[@]}"; do
    if [ -f "$file" ]; then
        cp -p -R "$file" "$file"
    fi
done

exit 0
