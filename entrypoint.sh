#!/usr/bin/env bash
#set -eu
set -eou pipefail

# Vars
ESC_SEQ="\\x1b["
RESET=$ESC_SEQ"39;49;00m"
YELLOW=$ESC_SEQ"33;01m"
RED=$ESC_SEQ"31;01m"

echo -e "${YELLOW}==> Linting JSON <==${RESET}"

fd -e json -x jsonlint -c {} \; 2> error.txt
#fd -e json -x jsonlint -q {} \; 2> error.txt
#fd -e json -x jsonlint -q {} \; 2> error.txt
#exec markdown-link-check {} \; 2> error.txt


if [ -e error.txt ] ; then
  if grep -q "ERROR:" error.txt; then
    echo -e "${RED}Please check the log${RESET}"
    exit 1
  fi
fi
