FILE=./README # create FILE variable
if ! [[ -f "$FILE" ]]; then # check if the file exists in the current directory
  echo "Downloading readme..."
  wget ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/ibiblio/gnome/README  # download the file
else
  echo "$FILE already exists, continuing..."
fi

COPY=./copy_of_readme # used as a temporary dump file to avoid reading/writing on the same file

tr '[:upper:]' '[:lower:]' < $FILE > $COPY && mv $COPY $FILE # make all text lowercase

#tr --delete '\n' < $COPY
sed -i 's/^$/ /g' $FILE # replace all linebreaks with spaces
tr --delete '\n' < $FILE > $COPY && mv $COPY $FILE # remove all new lines. words are now only separated by spaces
sed -i 's/ /\n/g' $FILE # replace every space with a newline. Every word is now on its own line
sed -i '/^$/d' $FILE  # delete empty lines
awk '{gsub(/[[:punct:]]/, "")} 1' RS='[[]]' $FILE > $COPY && mv $COPY $FILE # remove punctuation

# sorting pipeline example found on https://unix.stackexchange.com/questions/255761/sort-words-in-file
# sort contents of file alphabetically, remove duplicates and include number of duplicates found
cat < $FILE | sort | uniq -c > $COPY && mv $COPY $FILE

# sort contents of file by reverse, so that the highest number is on top. print only the second param (the word),
# and take the first 10 lines. This is not redirected to a file, but printed on stdout
cat < $FILE | sort -r | awk '{print $2}' | head -n 10

