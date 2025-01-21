#!/system/bin/sh

MODDIR=${0%/*}
BACKUP_DIR="$MODDIR/original"
BOOTPATH=$(cat "$MODDIR/bootpath.txt")

ui_print "- Starting module uninstallation..."

# Restore original
if [ -d "$BACKUP_DIR" ]; then
    ui_print "- Restoring original boot animations..."
    for file in "$BACKUP_DIR"/*.zip; do
        if [ -f "$file" ]; then
            mount -o rw,remount "$(dirname "$BOOTPATH")"
            cp -f "$file" "$BOOTPATH/"
            ui_print "  - Restored $(basename "$file")"
        fi
    done
else
    ui_print "! No backup found. Original animations cannot be restored."
fi

# Clean up
ui_print "- Cleaning up module files..."
rm -rf "$BACKUP_DIR"
ui_print "- Module uninstallation complete. Reboot to apply changes."
