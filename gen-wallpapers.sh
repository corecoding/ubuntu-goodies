#!/bin/bash

# https://help.ubuntu.com/community/SlideshowWallpapers

NAME='My Wallpapers'
DELAY=300.0
FADE=4.0
PAPERS='robot.jpg squirrel.jpg bsod.jpg'


WP_MAIN_PATH=~/.local/share/gnome-background-properties
WP_MAIN_FILE=MySlideshowCollection.xml

WP_PATH=~/.local/share/backgrounds/MyWallpapers
WP_FILE=MySlideshow.xml

FIRST=${PAPERS%% *}

mkdir -p $WP_MAIN_PATH
echo '<?xml version="1.0" encoding="UTF-8"?>' > $WP_MAIN_PATH/$WP_MAIN_FILE
echo '<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '<wallpapers>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '  <wallpaper>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo "    <name>$NAME</name>" >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo "    <filename>$WP_PATH/$WP_FILE</filename>" >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '    <options>zoom</options>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '    <pcolor>#2c001e</pcolor>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '    <scolor>#2c001e</scolor>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '    <shade_type>solid</shade_type>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '  </wallpaper>' >> $WP_MAIN_PATH/$WP_MAIN_FILE
echo '</wallpapers>' >> $WP_MAIN_PATH/$WP_MAIN_FILE

mkdir -p $WP_PATH
echo '<background>' > $WP_PATH/$WP_FILE
echo '  <starttime>' >> $WP_PATH/$WP_FILE
echo "    <year>`date +'%Y'`</year>" >> $WP_PATH/$WP_FILE
echo "    <month>`date +'%m'`</month>" >> $WP_PATH/$WP_FILE
echo "    <day>`date +'%d'`</day>" >> $WP_PATH/$WP_FILE
echo "    <hour>`date +'%H'`</hour>" >> $WP_PATH/$WP_FILE
echo "    <minute>`date +'%M'`</minute>" >> $WP_PATH/$WP_FILE
echo "    <second>`date +'%S'`</second>" >> $WP_PATH/$WP_FILE
echo '  </starttime>' >> $WP_PATH/$WP_FILE

LAST_IMAGE=''
for IMAGE in `echo $PAPERS $FIRST`; do
    if [ ! -e "$IMAGE" ]; then
        echo "Missing $IMAGE"
        continue
    else
        cp $IMAGE $WP_PATH/$IMAGE
    fi

    if [[ "$LAST_IMAGE" ]]; then
        echo '  <transition>' >> $WP_PATH/$WP_FILE
        echo "    <duration>$FADE</duration>" >> $WP_PATH/$WP_FILE
        echo "    <from>$WP_PATH/$LAST_IMAGE</from>" >> $WP_PATH/$WP_FILE
        echo "    <to>$WP_PATH/$IMAGE</to>" >> $WP_PATH/$WP_FILE
        echo '  </transition>' >> $WP_PATH/$WP_FILE

        if [[ "$FIRST" == "$IMAGE" ]]; then
            break
        fi
    fi

    echo '  <static>' >> $WP_PATH/$WP_FILE
    echo "    <duration>$DELAY</duration>" >> $WP_PATH/$WP_FILE
    echo "    <file>$WP_PATH/$IMAGE</file>" >> $WP_PATH/$WP_FILE
    echo '  </static>' >> $WP_PATH/$WP_FILE

    LAST_IMAGE=$IMAGE
done

echo '</background>' >> $WP_PATH/$WP_FILE
