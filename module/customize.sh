SKIPUNZIP=0

# Detect API and architecture
api_level_arch_detect

BOOT_DIR="/product/media"
BACKUP_DIR="$MODPATH/backups"
MODULES_DIR="/data/adb/modules/"
MODULE_ID=$(grep_prop id "$MODPATH/module.prop")
MODULE_VER_CODE=$(expr "$(grep_prop versionCode "$MODPATH/module.prop")" + 0)

# Recovery not recommended
if [[ "$BOOTMODE" != true ]]; then
  ui_print "*********************************************"
  ui_print "! Installing from recovery is not supported!"
  ui_print "! Please install via Magisk / KernelSU / APatch app"
  abort "*********************************************"
fi

# Check Android version
if [ "$API" -lt 30 ]; then
  ui_print "*********************************************"
  ui_print "! Android 11+ (API: 30+) required!"
  abort "*********************************************"
fi

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
      keycheck="$key_event"
      break
    fi
  done
}

backup() {
  ui_print "- Backing up boot animations from $BOOT_DIR"
  if [ -d "$BOOT_DIR" ]; then
    for FILE in "$BOOT_DIR"/bootanimation*; do
      if [ -f "$FILE" ]; then
        cp -f "$FILE" "$BACKUP_DIR/" && ui_print "- Cloned $(basename "$FILE")" || ui_print "! Unable to clone $(basename "$FILE")"
      fi
    done
  else
    ui_print "! $BOOT_DIR does not exist!"
    abort "*********************************************"
  fi
}

ui_print "*********************************************"
ui_print "- MI pad custom boot animation changer"
ui_print "- By Veutexus (github.com/G0246)"
ui_print "- ID: $MODULE_ID"
ui_print "- Version: $MODULE_VER_CODE"
ui_print "*********************************************"

# Check root manager
if [[ "$KSU" == "true" ]]; then
  ui_print "- KernelSU Userspace Version: $KSU_VER_CODE"
  ui_print "- KernelSU Kernel Space Version: $KSU_KERNEL_VER_CODE"
  if [ "$KSU_VER_CODE" -lt 11551 ]; then
    ui_print "*********************************************"
    ui_print "! KernelSU v0.8.0+ required!"
    abort "*********************************************"
  fi
elif [[ "$APATCH" == "true" ]]; then
  ui_print "- APatch Version: $APATCH_VER ($APATCH_VER_CODE)"
  ui_print "- KernelPatch Version: $KERNELPATCH_VERSION"
  ui_print "- KernelPatch Kernel Version: $KERNEL_VERSION"
  if [ "$APATCH_VER_CODE" -lt 10568 ]; then
    ui_print "*********************************************"
    ui_print "! APatch 10568+ required!"
    abort "*********************************************"
  fi
else
  ui_print "- Magisk Version: $MAGISK_VER ($MAGISK_VER_CODE)"
  if [ "$MAGISK_VER_CODE" -lt 26100 ]; then
    ui_print "*********************************************"
    ui_print "- Your current version of Magisk does not meet the minimum requirements"
    ui_print "  Would you like to proceed with the installation anyway?"
    ui_print "  Press the following keys to proceed:"
    ui_print "  Volume [+]: Continue"
    ui_print "  Volume [-]: Abort"
    ui_print "*********************************************"
    key_check
    if [[ "$keycheck" == "KEY_VOLUMEUP" ]]; then
      ui_print "- You chose to ignore the warning, unexpected bugs may occur"
      ui_print "- Proceeding with the installation"
    else
      ui_print "- Installation aborted"
      abort "*********************************************"
    fi
  fi
fi

# Device infos
ui_print "*********************************************"
ui_print "- Device Information:"
ui_print "  Brand: $(getprop ro.product.brand)"
ui_print "  Model: $(getprop ro.product.model)"
ui_print "  Android: $(getprop ro.build.version.release)"
ui_print "*********************************************"

# Create backup if not found
if [ ! -d "$MODULES_DIR$MODULE_ID/backups" ]; then
  ui_print "- Do you want to backup your current boot animation?"
  ui_print "  Press the following keys to proceed:"
  ui_print "  Volume [+]: Backup (RECOMMENDED)"
  ui_print "  Volume [-]: Skip"
  ui_print "*********************************************"
  key_check
  if [[ "$keycheck" == "KEY_VOLUMEUP" ]]; then
    mkdir -p "$BACKUP_DIR" && ui_print "- Created $BACKUP_DIR" || {
      ui_print "! Unable to create $BACKUP_DIR"
      abort "*********************************************"
    }
    backup
  else
    ui_print "- Skipping backup process"
  fi
else
  ui_print "- Found existing boot backups"
  ui_print "- Skipping backup process"
fi

ui_print "*********************************************"
ui_print "- Installation completed!"
ui_print "- Reboot to see new animations"
ui_print "*********************************************"
