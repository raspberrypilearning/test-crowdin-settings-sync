#!/usr/bin/env bash
set -e
crowdin string list --verbose | grep -F -- '--- /print-only ---' | awk '{print $1}' | tr -d '#' > ids.txt
echo "IDs to hide:"
cat ids.txt

while read -r id; do
  echo "Hiding string ID: $id"
  crowdin string edit "$id" --hidden
done < ids.txt