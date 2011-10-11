#!/usr/bin/env bash

#
# CBR2PDF - Convert CBR files 2 PDF (raw). 
# Hacking to read comic files on eReader (Sony PRS-505)
# Author: Mauro Navarro Baraldi
# Date: 11/10/2011
# Distributed under the GNU General Public License, version 2.0.
#

CONVERT=`whereis convert | awk '{print $2}'`
UNRAR=`whereis unrar | awk '{print $2}'`
SUBCHAR="_"

# Replace whitespaces in filenames for other defined in $SUBCHAR.
rename "s/ /$SUBCHAR/g" *.cbr

echo `pwd`

for COMIC in `ls *.cbr`;
    do
    TEMP=${COMIC%.*}
    mkdir $TEMP              # Create a temp dir with filename (without extension).
    $UNRAR e $COMIC $TEMP/   # Extract .cbr files images (jpg) to temp dir.
    $CONVERT $TEMP/*.jpg $TEMP.pdf
    rm -rf $TEMP/
    echo "Comic $TEMP converted sucefully"
done
