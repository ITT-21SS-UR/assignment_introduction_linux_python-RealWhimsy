#!/bin/bash
FILE=./README # create FILE variable
if ! [[ -f "$FILE" ]]; then # check if the file exists in the current directory
  echo "Downloading readme..."
  wget ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gnome/README # download the file if not exists
else
  echo "$FILE already exists, continuing..."
fi

cp ./README ./copy_of_readme                                                         # copy contents of file to another, to use for processing
COPY=./copy_of_readme                                                                # use as a copy, to not overwrite contents of original
MV_COPY=./copy_temp                                                                  # used to not read and write on the same file at the same time

tr '[:upper:]' '[:lower:]' <$COPY >$MV_COPY && mv $MV_COPY $COPY                     # make all text lowercase

sed -i 's/^$/ /g' "$COPY"                                                            # replace all linebreaks with spaces
tr --delete '\n' <"$COPY" >$MV_COPY && mv $MV_COPY "$COPY"                           # remove all new lines. words are now only separated by spaces
sed -i 's/ /\n/g' "$COPY"                                                            # replace every space with a newline. Every word is now on its own line
sed -i '/^$/d' "$COPY"                                                               # delete empty lines
awk '{gsub(/[[:punct:]]/, "")} 1' RS='[[]]' "$COPY" >$MV_COPY && mv $MV_COPY "$COPY" # remove punctuation

# sorting pipeline example found on https://unix.stackexchange.com/questions/255761/sort-words-in-file
# sort contents of file alphabetically, remove duplicates and include number of duplicates found
cat <"$COPY" | sort | uniq -c >$MV_COPY && mv $MV_COPY "$COPY"

# sort contents of file by reverse, so that the highest number is on top. print only the second param (the word),
# and take the first 10 lines. This is not redirected to a file, but printed on stdout
cat <"$COPY" | sort -r | awk '{print $2}' | head -n 10

rm $COPY # remove the copied file at the end
