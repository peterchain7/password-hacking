while IFS= read -r line1; do
    surname="${line1#*.}"
    cap_surname="$(tr '[:lower:]' '[:upper:]' <<< ${surname:0:1})${surname:1}"
    while IFS= read -r line2; do
        echo "${cap_surname}@${line2}"
    done < ren.txt
done < userNames.txt
