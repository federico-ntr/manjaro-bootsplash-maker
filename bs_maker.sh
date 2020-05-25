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

mkdir $NAME
sed "s/template/$NAME/g" ".template/bootsplash-manjaro-template.sh" > "$NAME/bootsplash-manjaro-$NAME.sh"
sed -i "s/logo.png/$LOGO/g" "$NAME/bootsplash-manjaro-$NAME.sh"
sed -i "s/spinner.gif/$SPINNER/g" "$NAME/bootsplash-manjaro-$NAME.sh"
sed "s/template/$NAME/g" ".template/bootsplash-manjaro-template.initcpio_install" > "$NAME/bootsplash-manjaro-$NAME.initcpio_install"
sed "s/template/$NAME/g" ".template/PKGBUILD" > "$NAME/PKGBUILD"
sed -i "s/logo.png/$LOGO/g" "$NAME/PKGBUILD"
sed -i "s/spinner.gif/$SPINNER/g" "$NAME/PKGBUILD"
sed "s/template/$NAME/g" ".template/README.md" > "$NAME/README.md"
cp ".template/bootsplash-packer" "$NAME/bootsplash-packer"
cp ".template/bootsplash-packer.rst" "$NAME/bootsplash-packer.rst"
cp "$LOGO" "$NAME/$(basename $LOGO)"
cp "$SPINNER" "$NAME/$(basename $SPINNER)"
