#!/bin/bash
# https://fedingo.com/how-to-fix-permission-denied-error-while-running-shell-script/
chmod +x ./filter7.sh
file="Maya-Angelou_poems/StillIRise.txt"
charLimit=7

# read
# logical or to prevent off-by-one and "no terminal newline" issue
while read -r line || [ -n "$line" ]
do
  if [ ${#line} -ge $charLimit ]; then
    echo $line
  else 
  # remove empty lines from print
    if [ ${#line} -ne 0 ]; then
    echo $line >> "Maya-Angelou_poems/filterPoem.txt"
    fi
  fi
done <$file
  # prevent editing of filter file with chattr immutability
sudo chattr +i Maya-Angelou_poems/StillIRise.txt
  # cleanup
# trap 'rm -f "$TMPFILE"' EXIT
# TMPFILE=Maya-Angelou_poems/filterPoem.txt|| exit 1
# echo "Our temp file is $TMPFILE"

