#!/bin/bash
usage() { echo "Usage: $0 [-l <logo> ] [-s <spinner> (optional)] [-n <name> (optional)]" 1>&2; exit 1; }

while getopts :l:s:n: opt; do
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
	echo "logo doesn't exist"
	exit 1
fi

if [[ ! -z "$SPINNER" ]] && [[ ! -f "$SPINNER" ]]
then
	SPINNER=".template/spinner.gif"
	echo "spinner doesn't exist, using default one"
elif [[ -z "$SPINNER" ]]
then
	SPINNER=".template/spinner.gif"
	echo "spinner not specified, using default one"
fi

FRAMES=$(identify -format "%n\n" $SPINNER | head -1)
THDIR="manjaro-bootsplash-$NAME"
mkdir $THDIR
#cp ".template/bootsplash-manjaro-template.sh" "$THDIR/bootsplash-manjaro-$NAME.sh"

sed "s/template/$NAME/g" ".template/bootsplash-manjaro-template.sh" > "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/logo.png/$(basename $LOGO)/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/spinner.gif/$(basename $SPINNER)/g" "$THDIR/bootsplash-manjaro-$NAME.sh"

for (( i=0; i<FRAMES; i++ ))
do
	echo -e "\t--blob throbber0$i.rgb \\" >> "$THDIR/bootsplash-manjaro-$NAME.sh"
done
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
