#!/system/bin/sh

# Recovery not recommended
if [ "$BOOTMODE" != true ]; then
    abort "! Installing from recovery is not supported, please install via Magisk app only"
fi

ui_print "- Device information:"
ui_print "- Brand：$(getprop ro.product.brand)"
ui_print "- Model：$(getprop ro.product.model)"
ui_print "- Android：$(getprop ro.build.version.release)"

# Error on < Android 11
if [ "$API" -lt 30 ]; then
    abort "! You can't use this module on Android < 11.0"
fi

# Will change in the future
if [ -f "/system/media/bootanimation.zip" ]; then
    ui_print "- Boot animation path is found"
else
    abort "! Unable to find boot animation directory or device not supported"
fi

sleep 1
ui_print ""
ui_print "- Module installation completed, restart to take effect"
ui_print "- By Veutexus (github.com/G0246)"