#!/bin/bash
#
# A simple script to show how to create a bootsplash.
# Do with it whatever you wish.
#
# This needs ImageMagick for the 'convert' and 'identify' tools.
#

LOGO=logo.png
LOGO_WIDTH=$(identify $LOGO | cut -d " " -f 3 | cut -d x -f 1)
LOGO_HEIGHT=$(identify $LOGO | cut -d " " -f 3 | cut -d x -f 2)

THROBBER=spinner.gif
THROBBER_WIDTH=$(identify $THROBBER | head -1 | cut -d " " -f 3 | \
						cut -d x -f 1)
THROBBER_HEIGHT=$(identify $THROBBER | head -1 | cut -d " " -f 3 | \
						 cut -d x -f 2)

convert -alpha remove \
	-background "#XXYYZZ" \
	$LOGO \
	logo.rgb

convert -alpha remove \
	-background "#XXYYZZ" \
	$THROBBER \
	throbber%02d.rgb


#make clean
#make bootsplash-packer


# Let's put Tux in the center of an orange background.
./bootsplash-packer \
	--bg_red 0xXX \
	--bg_green 0xYY \
	--bg_blue 0xZZ \
	--frame_ms 48 \
	--picture \
	--pic_width $LOGO_WIDTH \
	--pic_height $LOGO_HEIGHT \
	--pic_position 0 \
	--blob logo.rgb \
	--picture \
	--pic_width $THROBBER_WIDTH \
	--pic_height $THROBBER_HEIGHT \
	--pic_position 0x05 \
	--pic_position_offset 200 \
	--pic_anim_type 1 \
	--pic_anim_loop 0 \
