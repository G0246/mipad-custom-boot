#!/system/bin/sh

MODDIR=${0%/*}
BACKUP_DIR="/sdcard/Download/Bootanimation_backups"
BOOTPATH=$(cat "$MODDIR/bootpath.txt")

# Restore original
if [ -d "$BACKUP_DIR" ]; then
    for file in "$BACKUP_DIR"/*.zip; do
        if [ -f "$file" ]; then
            mount -o rw,remount "$(dirname "$BOOTPATH")"
            cp -f "$file" "$BOOTPATH/"
        fi
    done
fi

# Clean up
rm -rf "$BACKUP_DIR"