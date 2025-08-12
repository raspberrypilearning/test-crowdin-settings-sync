#!/usr/bin/env bash
set -e
crowdin string list --verbose | grep -- '--- /no-print ---' | awk '{print $1}' | tr -d '#'

while read -r id; do
  echo "Hiding string ID: $id"
  crowdin string edit "$id" --hidden
done