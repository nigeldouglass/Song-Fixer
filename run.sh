#!/bin/bash
parentdir="$(dirname "$0")"
dir="${parentdir//\\//}"
FILES=$dir/*.mp3
c=$(ls -lR $FILES | wc -l)
max=22
echo '['$c'] found!'
if [ $c -ne 0 ]
then
	for f in $FILES
	do
	disk=1
	name=$(basename "$f");
		num=$( cut -d '.' -f 1 <<< "$name" );
		if (("$num" > "$max"))
		then
			num=$((num-max))
			disk=2
		fi
		tmp=${name%%-*}
		temp1=$(( ${#tmp} - 1 ))
		tmp=${name%%.*}
		temp2=$(( ${#tmp} + 3 ))
		artists=`echo $name | cut -c$temp2-$temp1`
		
		tmp=${name%%.mp3*}
		temp3=$(( ${#tmp} +0 ))
		temp1=$((temp1+4))
		song=`echo $name | cut -c$temp1-$temp3`
		echo $song
		echo `ffmpeg -i "$f" -metadata title="$song" -metadata artist="$artists" -codec copy "$disk"/"$song".mp3 -y`
	done
fi
read -p "Press enter to continue"