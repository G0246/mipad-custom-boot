#!/system/bin/sh
SKIPUNZIP=0

key_check() {
  while true; do
    key_check=$(/system/bin/getevent -qlc 1)
    key_event=$(echo "$key_check" | awk '{ print $3 }' | grep 'KEY_')
    key_status=$(echo "$key_check" | awk '{ print $4 }')
    if [[ "$key_event" == *"KEY_"* && "$key_status" == "DOWN" ]]; then
      keycheck="$key_event"
      break
    fi
  done
  while true; do
    key_check=$(/system/bin/getevent -qlc 1)
    key_event=$(echo "$key_check" | awk '{ print $3 }' | grep 'KEY_')
    key_status=$(echo "$key_check" | awk '{ print $4 }')
    if [[ "$key_event" == *"KEY_"* && "$key_status" == "UP" ]]; then
      break
    fi
  done
}

ui_print "*********************************************"
ui_print "- mi-pad-custom-boot"
ui_print "- By Veutexus (github.com/G0246)"
ui_print "*********************************************"

# Check Magisk version
if [ "$MAGISK_VER_CODE" -lt 26100 ]; then
  abort "! Error: Magisk v26.1+ required!"
fi

# Check Android version
if [[ "$API" -lt 30 ]]; then
  abort "! Error: Android 11+ required!"
fi

# Device infos
ui_print "- Device Information:"
ui_print "  Brand: $(getprop ro.product.brand)"
ui_print "  Model: $(getprop ro.product.model)"
ui_print "  Android: $(getprop ro.build.version.release)"
ui_print "  Magisk: $MAGISK_VER ($MAGISK_VER_CODE)"

BOOTPATH="/product/media"
BACKUP_DIR="$MODPATH/backups"

# Create backup folder if not found
ui_print "*********************************************"
ui_print "- Do you want to backup your current boot animation? (Only for first time installation)"
ui_print "  Press the following keys to proceed:"
ui_print "  Volume + to backup"
ui_print "  Volume - to skip"
ui_print "*********************************************"
key_check
if [ "$keycheck" == "KEY_VOLUMEUP" ]; then
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR" && ui_print "- Created $BACKUP_DIR" || {
      ui_print "! Unable to create backup directory at $BACKUP_DIR!"
      abort
    }
  else
    ui_print "- Using existing $BACKUP_DIR"
  fi

  ui_print "- Backing up boot animations from $BOOTPATH"
  if [ -d "$BOOTPATH" ]; then
    for file in "$BOOTPATH"/bootanimation*; do
      if [ -f "$file" ]; then
        cp -f "$file" "$BACKUP_DIR/" && {
          ui_print "- Cloned $(basename "$file")"
        } || {
          ui_print "! Unable to clone $(basename "$file") to $BACKUP_DIR"
          abort
        }
      fi
    done
  else
    ui_print "! $BOOTPATH does not exist!"
    abort
  fi
else
  ui_print "- Skipping backup process."
fi

ui_print "*********************************************"
ui_print "- Installation completed!"
ui_print "- Reboot to see new animations."
ui_print "*********************************************"