#!/system/bin/sh
MODDIR=${0%/*}

SOURCE_DIR="$MODDIR/system/media"
DEST_DIR="/system/media"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory $SOURCE_DIR does not exist" >> /cache/magisk.log
    exit 1
fi

for file in "$SOURCE_DIR"/*.zip; do
    if [ -f "$file" ]; then
        cp -f "$file" "$DEST_DIR/"
        echo "Replaced $(basename "$file") in $DEST_DIR" >> /cache/magisk.log
    fi
done

log_message="Custom boot animations systemlessly applied from $MODDIR/system/media"
echo "$log_message" >> /cache/magisk.log