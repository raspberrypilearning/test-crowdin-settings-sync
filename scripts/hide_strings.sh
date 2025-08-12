#!/usr/bin/env bash
set -e
crowdin string list --verbose | grep -F -- '--- /print-only ---' | awk '{print $1}' | tr -d '#' |
while read -r id; do
  crowdin string edit "$id" --hidden
done
