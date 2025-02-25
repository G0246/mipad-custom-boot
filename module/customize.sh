#!/system/bin/sh
SKIPUNZIP=0
api_level_arch_detect

BOOT_PATH="/product/media"
BACKUP_DIR="$MODPATH/backups"
MODULE_PATH=/data/adb/modules/
MODULE_ID=$(grep_prop id "$MODPATH/module.prop")
MODULE_VER_CODE=$(expr "$(grep_prop versionCode "$MODPATH/module.prop")" + 0)

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

backup() {
  ui_print "- Backing up boot animations from $BOOT_PATH"
  if [ -d "$BOOT_PATH" ]; then
    for file in "$BOOT_PATH"/bootanimation*; do
      if [ -f "$file" ]; then
        cp -f "$file" "$BACKUP_DIR/" && {
          ui_print "- Cloned $(basename "$file")"
        } || {
          ui_print "! Error: Unable to clone $(basename "$file")"
          abort "*********************************************"
        }
      fi
    done
  else
    ui_print "! $BOOT_PATH does not exist!"
    abort "*********************************************"
  fi
}

ui_print "*********************************************"
ui_print "- mipad-custom-boot"
ui_print "- By Veutexus (github.com/G0246)"
ui_print "- Version: $MODULE_VER_CODE"
ui_print "*********************************************"

# Check root manager
if [[ "$KSU" == "true" ]]; then
  ui_print "- KernelSU Userspace Version: $KSU_VER_CODE"
  ui_print "- KernelSU Kernel Space Version: $KSU_KERNEL_VER_CODE"
  if [ "$KSU_VER_CODE" -lt 11551 ]; then
    ui_print "*********************************************"
    ui_print "- Error: KernelSU v0.8.0+ required!"
    abort "*********************************************"
  fi
elif [[ "$APATCH" == "true" ]]; then
  ui_print "- APatch Version Code: $APATCH_VER_CODE"
  ui_print "- APatch Version: $APATCH_VER"
  ui_print "- KernelPatch Userspace Version: $KERNELPATCH_VERSION"
  ui_print "- KernelPatch Kernel Space Version: $KERNEL_VERSION"
  if [ "$APATCH_VER_CODE" -lt 10568 ]; then
    ui_print "*********************************************"
    ui_print "- Error: APatch 10568+ required!"
    abort "*********************************************"
  fi
else
  ui_print "- Magisk Version: $MAGISK_VER ($MAGISK_VER_CODE)"
  if [ "$MAGISK_VER_CODE" -lt 26000 ]; then
    ui_print "*********************************************"
    ui_print "! Error: Magisk v26.0+ required!"
    abort "*********************************************"
  fi
fi

# Check Android version
if [[ "$API" -lt 30 ]]; then
  ui_print "*********************************************"
  ui_print "! Error: Android 11+ (API: 30+) required!"
  abort "*********************************************"
fi

# Device infos
ui_print "*********************************************"
ui_print "- Device Information:"
ui_print "  Brand: $(getprop ro.product.brand)"
ui_print "  Model: $(getprop ro.product.model)"
ui_print "  Android: $(getprop ro.build.version.release)"
ui_print "*********************************************"

# Create backup if not found
if [ ! -d "$MODULE_PATH$MODULE_ID/backups" ]; then
  ui_print "- Do you want to backup your current boot animation?"
  ui_print "  Press the following keys to proceed:"
  ui_print "  Volume [+]: Backup (RECOMMENDED)"
  ui_print "  Volume [-]: Skip"
  ui_print "*********************************************"
  key_check
  if [ "$keycheck" == "KEY_VOLUMEUP" ]; then
    mkdir -p "$BACKUP_DIR" && ui_print "- Created $BACKUP_DIR" || {
      ui_print "! Error: Unable to create $BACKUP_DIR"
      abort "*********************************************"
    }
    backup
  else
    ui_print "- Skipping backup process."
  fi
else
  ui_print "- Found existing boot backups."
  ui_print "- Skipping backup process."
fi

ui_print "*********************************************"
ui_print "- Installation completed!"
ui_print "- Reboot to see new animations."
ui_print "*********************************************"