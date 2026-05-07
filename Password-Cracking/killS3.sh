while IFS= read -r line1; do
    firstname="${line1%%.*}"   # extract text before the dot
    cap_firstname="$(tr '[:lower:]' '[:upper:]' <<< ${firstname:0:1})${firstname:1}"

    while IFS= read -r line2; do
        echo "${cap_firstname}@${line2}"
    done < years.txt
done < userNames.txt >> riani.txt
