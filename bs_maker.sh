#!/bin/bash
LOGO=$1
SPINNER=$2 #optional
NAME=$3 #optional, default value is $LOGO

if [ -z "$LOGO" ]
then
	echo "You must specify logo name"
	exit 2
fi

if [ -z "$NAME" ]
then
	echo "Name not specified, using logo name"
	NAME="$(basename $LOGO)"
	NAME="${NAME%.png}"
	echo $NAME
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

THDIR="manjaro-bootsplash-$NAME"
mkdir $THDIR

sed "s/template/$NAME/g" ".template/bootsplash-manjaro-template.sh" > "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/logo.png/$(basename $LOGO)/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
sed -i "s/spinner.gif/$(basename $SPINNER)/g" "$THDIR/bootsplash-manjaro-$NAME.sh"
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
