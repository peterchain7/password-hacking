#!/bin/bash

# List of files in processing order
files=("animals.txt" "football.txt" "taasisi.txt" "tz-region-district.txt" \
       "rivers.txt" "tz-usernames.txt" "football-players.txt" "others.txt" "rockyou_clean.txt")

# Temp file to track lines already seen
temp_file=$(mktemp)

# Function: capitalize first letter of a word
capitalize_word() {
    awk '{for(i=1;i<=NF;i++){w=$i; if(length(w)>1){ $i=toupper(substr(w,1,1)) substr(w,2) } else { $i="" } } print $0}'
}

for f in "${files[@]}"; do
    # Split into words, capitalize, remove single-char words
    awk '{for(i=1;i<=NF;i++) if(length($i)>1) print toupper(substr($i,1,1)) substr($i,2)}' "$f" > "$f.tmp"

    # Remove lines already seen in previous files
    if [[ -s "$temp_file" ]]; then
        grep -vFf "$temp_file" "$f.tmp" > "$f.tmp2"
        mv "$f.tmp2" "$f.tmp"
    fi

    # Remove duplicates inside current file
    awk '!seen[$0]++' "$f.tmp" > "$f"
    
    # Add current file lines to temp_file
    cat "$f" >> "$temp_file"
    
    # Cleanup temp
    rm -f "$f.tmp"
done

# Cleanup temp
rm "$temp_file"

echo "Done! All files updated: one word per line, capitalized, unique across files."
