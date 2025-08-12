#!/usr/bin/env bash
set -e
# crowdin string list --verbose | grep -- '--- /no-print ---' | awk '{print $1}' | tr -d '#' > ids.txt
# echo "IDs to hide:"
# cat ids.txt

# while read -r id; do
#   echo "Hiding string ID: $id"
#   crowdin string edit "$id" --hidden
# done < ids.txt

crowdin string list | awk '
  /^#/ {
    # When you hit an ID line, save it and reset content
    if (id) {
      # check if previous string content matched pattern
      if (content ~ /--- \/print-only ---/) {
        print id
      }
    }
    id=$1
    content=""
    next
  }
  {
    # accumulate multiline string content
    content = content $0 "\n"
  }
  END {
    # check last string
    if (content ~ /--- \/print-only ---/) {
      print id
    }
  }
' | tr -d '#' | while read -r id; do
  if [[ -n "$id" ]]; then
    echo "Hiding string ID: $id"
    crowdin string edit "$id" --hidden
  fi
done