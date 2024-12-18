#!/system/bin/sh

# Recovery not recommended
if [ "$BOOTMODE" != true ]; then
    abort "! Installing from recovery is not supported, please install via Magisk app only"
fi

if [ "$MAGISK_VER_CODE" -lt 26100 ]; then
    abort "! Magisk version must be 26.1 or higher. Current version: $MAGISK_VER_CODE"
fi

ui_print "- Device information:"
ui_print "- Brand：$(getprop ro.product.brand)"
ui_print "- Model：$(getprop ro.product.model)"
ui_print "- Android：$(getprop ro.build.version.release)"
ui_print "- Magisk: $MAGISK_VER"

# Error on < Android 11
if [ "$API" -lt 30 ]; then
    abort "! You can't use this module on Android < 11.0"
fi

ui_print "- Checking boot animation path for better compatibility"
if [ -f "/system/product/media/bootanimation.zip" ]; then
    bootpath =/system/product/media/
elif [ -f "/system/media/bootanimation.zip" ]; then
    bootpath =/system/media/
elif [ -f "/vendor/media/bootanimation.zip" ]; then
    abort "! Device not supported yet"
elif [ -f "/product/media/bootanimation.zip" ]; then
    abort "! Device not supported yet"
elif [ -f "/my_product/media/bootanimation/bootanimation.zip" ]; then
    abort "! Device not supported yet"
elif [ -f "/oppo_product/media/bootanimation/bootanimation.zip" ]; then
    abort "! Device not supported yet"
else
    abort "! Unable to find bootanimation.zip or device not supported"
fi

ui_print "- Found boot animation at $bootpath"
echo "$bootpath" > "$MODPATH/bootpath.txt"
sleep 1
ui_print ""
ui_print "- Module installation completed, restart to take effect"
ui_print "- By Veutexus (github.com/G0246)"