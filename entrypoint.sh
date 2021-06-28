#!/usr/bin/env bash
#set -eu
set -eou pipefail

# Vars
ESC_SEQ="\\x1b["
RESET=$ESC_SEQ"39;49;00m"
YELLOW=$ESC_SEQ"33;01m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"

FILE=/home/node/error.log
touch $FILE
chmod a+w $FILE

echo -e "${YELLOW}==> Linting JSON <==${RESET}"
echo -e "Checking these files:"
fd --extension json -X ls -ld
echo -e "Results:"
fd --extension json --exec jsonlint --quiet --compact | tee $FILE
if [ -s "$FILE" ]; then
    echo -e "${RED}Ooh, there was an error${RESET}"
    echo ::set-output name=exit_code::1
else
    echo -e "${GREEN}Great, all good${RESET}"
    echo ::set-output name=status::'Success'
fi
