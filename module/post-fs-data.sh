#!/system/bin/sh
MODDIR=${0%/*}

# Check if path exists
if [ -f "$MODDIR/bootpath.txt" ]; then
    BootAnimPath=$(dirname "$(cat "$MODDIR/bootpath.txt")")
else
    exit 1
fi

cd "$BootAnimPath" || exit 1

boot_animations=(
    "bootanimation.zip"
    "bootanimation01.zip"
    "bootanimation02.zip"
    "bootanimation03.zip"
    "bootanimation04.zip"
)

for file in "${boot_animations[@]}"; do
    if [ -f "$file" ]; then
        cp -p -R "$file" "$file"
    fi
done

exit 0
