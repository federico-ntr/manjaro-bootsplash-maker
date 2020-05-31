#!/bin/bash
usage() { echo "Usage: $0 [-l <logo> ] [-s <spinner> (optional)] [-n <name> (optional)] [-p <position> (optional)] [-c <hexcolor> (optional)]" 1>&2; exit 1; }

while getopts :l:s:n:p:c: opt; do
	case $opt in
		l) LOGO=${OPTARG}
			;;
		s) 
			if [ -z "${OPTARG}" ]
			then
				usage
			else
				SPINNER=${OPTARG}
			fi
			;;
		n) NAME=${OPTARG}
			;;
		p) 
			if [ -z "${OPTARG}" ]
			then
				usage
			else
				case ${OPTARG} in
					tl) POSITION=00
						;;
					t) POSITION=01
						;;
					tr) POSITION=02
						;;
					r) POSITION=03
						;;
					br) POSITION=04
						;;
					b) POSITION=05 #default
						;;
					bl) POSITION=06
						;;
					l) POSITION=07
						;;
				esac
			fi
			;;
		c)
			if [ -z "${OPTARG}" ]
			then
				usage
			else
				RCOLOR=${OPTARG:0:2}
				GCOLOR=${OPTARG:2:2}
				BCOLOR=${OPTARG:4}
			fi
			;;
		:)
      		echo "Error: -${OPTARG} requires an argument."
      		usage
      		exit 1
      		;;
	esac
done

if [ -z "$LOGO" ]
then
	usage
fi

if [ -z "$NAME" ]
then
	NAME="$(basename $LOGO)"
	NAME="${NAME%.png}"
	echo "Name not specified, using logo name: $NAME"
fi

if [ ! -f "$LOGO" ]
then
	echo "Logo doesn't exist"
	exit 1
fi

if [[ ! -z "$SPINNER" ]] && [[ ! -f "$SPINNER" ]]
then
	SPINNER=".template/spinner.gif"
	echo "Spinner doesn't exist, using default one"
elif [[ -z "$SPINNER" ]]
then
	SPINNER=".template/spinner.gif"
	echo "Spinner not specified, using default one"
fi

if [ -z "$POSITION" ]
then
	POSITION=05
	echo "Position not specified, using default one: bottom"
fi

if [ -z "$RCOLOR" ]
then
	RCOLOR=00
	GCOLOR=00
	BCOLOR=00
	echo "Color not specified, using default one: black"
fi

FRAMES=$(identify -format "%n\n" $SPINNER | head -1)
THDIR="manjaro-bootsplash-$NAME"
mkdir $THDIR
#cp ".template/bootsplash-manjaro-template.sh" "$THDIR/bootsplash-manjaro-$NAME.sh"

sed "s/template/$NAME/g" ".template/bootsplash-manjaro-template.sh" > "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/logo.png/$(basename $LOGO)/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/spinner.gif/$(basename $SPINNER)/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/05/$POSITION/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/XX/$RCOLOR/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/YY/$GCOLOR/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/ZZ/$BCOLOR/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
if [[ ! $FRAMES -ge 10 ]]
then
	for (( i=0; i<FRAMES; i++ ))
	do
		echo -e "\t--blob throbber0$i.rgb \\" >> "$THDIR/bootsplash-manjaro-$NAME.sh"
	done
else
	for (( i=0; i<10; i++ ))
	do
		echo -e "\t--blob throbber0$i.rgb \\" >> "$THDIR/bootsplash-manjaro-$NAME.sh"
	done
	for (( i=10; i<FRAMES; i++ ))
	do
		echo -e "\t--blob throbber$i.rgb \\" >> "$THDIR/bootsplash-manjaro-$NAME.sh"
	done
fi
echo -e "\tbootsplash-manjaro-$NAME" >> "$THDIR/bootsplash-manjaro-$NAME.sh"
echo >> "$THDIR/bootsplash-manjaro-$NAME.sh"
echo "rm *.rgb" >> "$THDIR/bootsplash-manjaro-$NAME.sh"

sed "s/template/$NAME/g" ".template/bootsplash-manjaro-template.initcpio_install" > "$THDIR/bootsplash-manjaro-$NAME.initcpio_install"
sed "s/template/$NAME/g" ".template/PKGBUILD" > "$THDIR/PKGBUILD"
sed -i "s/logo.png/$(basename $LOGO)/g" "$THDIR/PKGBUILD"
sed -i "s/spinner.gif/$(basename $SPINNER)/g" "$THDIR/PKGBUILD"
sed "s/template/$NAME/g" ".template/README.md" > "$THDIR/README.md"
cp ".template/bootsplash-packer" "$THDIR/bootsplash-packer"
cp ".template/bootsplash-packer.rst" "$THDIR/bootsplash-packer.rst"
cp "$LOGO" "$THDIR/$(basename $LOGO)"
cp "$SPINNER" "$THDIR/$(basename $SPINNER)"

#( cd "$THDIR" && makepkg -sci ) for building and installing directly
