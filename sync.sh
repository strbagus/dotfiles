#!/bin/bash

SRC_FOLDER="$HOME/path/to/main"
DEST_FOLDER="$HOME/path/to/share"

mapfile -t FILES < <(comm -12 <(ls "$SRC_FOLDER") <(ls "$DEST_FOLDER"))
for file in "${FILES[@]}"; do
  src="$SRC_FOLDER/$file"
  dest="$DEST_FOLDER/$file"
  if ! cmp -s "$src" "$dest"; then
    no=$(($no+1))
    src_modified=$(stat -c %Y "$src")
    dest_modified=$(stat -c %Y "$dest")
    if (( src_modified < dest_modified )); then
      echo "Pull: $file"
      rsync -raz "$dest" "$SRC_FOLDER"
    else
      echo "Push: $file"
      rsync -raz "$src" "$DEST_FOLDER"
    fi
  fi
done
if [ $no>0 ]; then
  echo "File Synced: $no"
else
  echo "All File Already Synced."
fi

