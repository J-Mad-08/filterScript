#!/bin/bash
# https://fedingo.com/how-to-fix-permission-denied-error-while-running-shell-script/
chmod +x ./filter7.sh
file="Poe_poems/TheRaven.txt"
charLimit=7

# read
# logical or to prevent off-by-one and "no terminal newline" issue
while read -r line || [ -n "$line" ]
do 
  wordCount=$(IFS=' '; set -f -- $line; echo $#)
# Print out every line of the file that is at least 7 characters long
  if [ $wordCount -ge $charLimit ]; then
    echo $line
    # Write a new file containing the lines of the first text file which were shorter than 7 characters
    else 
      echo $line >> Poe_poems/filterPoem.txt
  fi
done <$file
  # prevent editing of filter file with chattr immutability
sudo chattr +i Poe_poems/filterPoem.txt
  # cleanup
# trap 'rm -f "$TMPFILE"' EXIT
# TMPFILE=Poe_poems/filterPoem.txt|| exit 1
# echo "Our temp file is $TMPFILE"

