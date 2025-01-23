#!/system/bin/sh

# Recovery not supported
if [ "$BOOTMODE" != true ]; then
    abort "! Installing from recovery is not supported. Use the Magisk app."
fi

# Check Magisk version
if [ "$MAGISK_VER_CODE" -lt 26100 ]; then
    abort "! Magisk version must be 26.1 or higher. Current version: $MAGISK_VER_CODE"
fi

# Device infos
ui_print "- Device information:"
ui_print "- Brand: $(getprop ro.product.brand)"
ui_print "- Model: $(getprop ro.product.model)"
ui_print "- Android: $(getprop ro.build.version.release)"
ui_print "- Magisk: $MAGISK_VER"

# Error on < Android 11
if [ "$API" -lt 30 ]; then
    abort "! Android 11 or higher is required."
fi

ui_print "- Checking boot animation path..."
if [ -f "/system/product/media/bootanimation.zip" ]; then
    BOOTPATH="/system/product/media"
elif [ -f "/system/media/bootanimation.zip" ]; then
    BOOTPATH="/system/media"
elif [ -f "/vendor/media/bootanimation.zip" ]; then
    BOOTPATH="/vendor/media"
else
    abort "! Boot animation not found. Device unsupported."
fi

ui_print "- Boot animation found at $BOOTPATH"

BACKUP_DIR="/sdcard/Download/Bootanimation_backups"
SOURCE_DIR="$MODPATH/system/media"
BOOTPATH_FILE="$MODDIR/bootpath.txt"

echo "$BOOTPATH" > "$BOOTPATH_FILE"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Backup
ui_print "- Backing up existing boot animations..."
mkdir -p "$BACKUP_DIR"
for file in bootanimation.zip bootanimation01.zip bootanimation02.zip bootanimation03.zip bootanimation04.zip; do
    if [ -f "$BOOTPATH/$file" ]; then
        cp -f "$BOOTPATH/$file" "$BACKUP_DIR/"
        ui_print "- Backed up $file"
    fi
done

# Replace
ui_print "- Replacing boot animations with new files..."
for file in "$SOURCE_DIR"/*.zip; do
    if [ -f "$file" ]; then
        mount -o rw,remount "$(dirname "$BOOTPATH")"
        cp -f "$file" "$BOOTPATH/"
        ui_print "- Replaced $(basename "$file")"
    fi
done

ui_print ""
ui_print "- Module installation complete. Reboot to apply changes."
ui_print "- By Veutexus (github.com/G0246)"