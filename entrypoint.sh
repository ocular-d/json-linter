#!/usr/bin/env bash
#set -eu
set -eou pipefail

# Vars
ESC_SEQ="\\x1b["
RESET=$ESC_SEQ"39;49;00m"
YELLOW=$ESC_SEQ"33;01m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"

ERROR_LOG=/home/node/error.log
touch $ERROR_LOG
chmod a+w $ERROR_LOG

split_on_commas() {
  local IFS=,
  local FILE_LIST=("$1")
  for file in "${FILE_LIST[@]}"; do
    echo "$file"
  done
}

echo -e "${YELLOW}==> Linting JSON <==${RESET}"
split_on_commas "$1" | while read -r item; do
  # Custom logic goes here
  echo -e "Validating: ${item}"
  jsonlint --quiet --compact "${item}" | tee $ERROR_LOG
  if [ -s "$ERROR_LOG" ]; then
    echo -e "${RED}Ooh, there was an error${RESET}"
    echo ::set-output name=exit_code::1
  else
    echo -e "${GREEN}Great, all good${RESET}"
    echo ::set-output name=status::'Success'
  fi
done

