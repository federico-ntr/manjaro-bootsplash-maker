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

echo $LOGO
