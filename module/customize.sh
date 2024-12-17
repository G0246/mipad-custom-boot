#!/system/bin/sh

# Recovery not recommended
if [ "$BOOTMODE" != true ]; then
    abort "! Installing from recovery is not supported, please install via Magisk app only!"
fi

# Error on < Android 11
if [ "$API" -lt 30 ]; then
    abort "! You can't use this module on Android < 11.0"
fi

if [ -f "/system/media/bootanimation.zip" ]; then
    ui_print "- Boot animation path is found"
else
    abort "! Unable to find boot animation directory or not supported, please wait for a future update"
fi

REPLACE="/system/media/"

ui_print ""
ui_print "- Module installation completed, restart to see the effect."
ui_print "- By Veutexus (github.com/G0246)"