#!/usr/bin/env bash
set -e
# crowdin string list --verbose | grep -- '--- /no-print ---' | awk '{print $1}' | tr -d '#' > ids.txt
# echo "IDs to hide:"
# cat ids.txt

# while read -r id; do
#   echo "Hiding string ID: $id"
#   crowdin string edit "$id" --hidden
# done < ids.txt

echo "DEBUG: Listing all strings with IDs and content:"
crowdin string list

echo "DEBUG: Extracting candidate IDs with matching content:"
crowdin string list | awk '
  /^#/ {
    if (id) {
      if (content ~ /--- \/print-only ---/) print id;
    }
    id=$1; content="";
    next
  }
  { content = content $0 "\n" }
  END { if (content ~ /--- \/print-only ---/) print id }
' | tr -d '#'