#!/bin/bash
set -euo pipefail

bucket="$1"
dir="$2"

mkdir -p "$dir"
aws s3 cp "s3://$bucket" "$dir" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt
find "$(realpath "$dir")" -type f -name "*.txt" | sort >> book_list.txt

count=$(tail -n +2 book_list.txt | wc -l)
echo "Wrote $count book files to book_list.txt"
