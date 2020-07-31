#!/usr/bin/env bash
#set -eu
set -eou pipefail

# Vars
ESC_SEQ="\\x1b["
RESET=$ESC_SEQ"39;49;00m"
YELLOW=$ESC_SEQ"33;01m"
RED=$ESC_SEQ"31;01m"

FILE=error.log

echo -e "${YELLOW}==> Linting JSON <==${RESET}"

fd -e json -x jsonlint -c | tee error.log
if [ -s "$FILE" ]; then
    echo -e "${RED}Ooh, there was an error${NC}"
    echo ::set-output name=exit_code::1
else
    echo -e "${GREEN}Great, all good${NC}"
    echo ::set-output name=status::'Success'
fi

