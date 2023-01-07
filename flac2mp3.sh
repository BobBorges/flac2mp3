#!/bin/bash


# makes mp3 versions of a folder full of flac files. 
# dumps mp3 files into a subfolder called em-pee-three


d="$1"

echo "checking for flac files in $d"


convert_flac () {
	echo "Converting Flac files"
	echo " ~> making em-pee-three/ dir"
	mkdir "${d}/em-pee-three"
	for f in "${d}"/*.flac; do
		base="${f##*/}"
		base_f="${base%.*}"
		echo " ---> converting ${f} to ${d}/em-pee-three/${base_f}.mp3"
		ffmpeg -i "${f}" -ab 320k -map_metadata 0 -id3v2_version 3 "${d}/em-pee-three/${base_f}.mp3"
	done
}

isflac=0

for f in "${d}"/* ; do
	echo "${f}"
	if [[ "${f}" == *.flac ]] ; then
		echo "is flac"
		isflac=1
		break
	else
		echo "not flac"
 	fi
done

if [ $isflac == 1 ] ; then
	echo " +++ Flac files found"
	#mkdir em-pee-three
	convert_flac
else
	echo " --- No flac files found"
fi



