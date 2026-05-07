#!/bin/bash
while IFS= read -r line1; do
    while IFS= read -r line2; do
        echo "${line1}@${line2}"
    done < years.txt
done < UserName.txt >> riani.txt