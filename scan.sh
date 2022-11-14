#/bin/bash

	#bash ocr script
	#develop by emmanuel.d.breyaue
	#github: ebreyaue
	#write me: hello[at]emmanuelbreyaue.com
	#credits to blog.desdelinux.net


function logo()
{

echo "  ___   ____ ____  ____            _       _ "  
echo " / _ \ / ___|  _ \/ ___|  ___ _ __(_)_ __ | |"_ 
echo "| | | | |   | |_) \___ \ / __| '__| | '_ \| __|"
echo "| |_| | |___|  _ < ___) | (__| |  | | |_) | |_" 
echo " \___/ \____|_| \_\____/ \___|_|  |_| .__/ \__|"
echo "                                    |_|        "
echo "________________________________________________"
echo " "

echo "develop by emmanuel d. breyaue"
echo "github: ebreyaue"
echo "contact: hello[at]emmanuelbreyaue.com"
}

clear
logo

#option 
P="-p"
D="-d"


#device configuration
DEV="hpaio:/usb/Photosmart_C5200_series?serial=BR88IGB05H04XQ"
MODE="--mode Gray"
RESOLUTION="--resolution 150"
x0=0
y0=0
width=189
height=270

#options
L="-l $x0"
T="-t $y0"
WIDTH="-x $width"
HEIGHT="-y $height"

#parameters
PARAMETERS="$D $DEV $P $MODE $RESOLUTION $L $T $WIDTH $HEIGHT"

echo "Name of publish:";
read FOLDER


mkdir $FOLDER

if [ "$?" = "1" ];then
exit 100
fi

FILE=$FOLDER"/"$FOLDER"_sheet_"



function question()
{
echo "scanned docs:" "$I"
echo -e "Press n to exit  Any key to continue" 
read -s -n1 -p "scan new document?" keypress
}


I=1
#question
while [ "$keypress" != "n" ]; do
#scanning image
let "I +=1"
NAME=$FILE$I
scanimage $PARAMETERS|convert - $NAME.jpg
question
done

#convert to text
J=1
for((J==1;J<=I;J++))
do 
tesseract $FILE$J".jpg" $FILE$J
#echo "./"$FILE$J".jpg"
done

exit
