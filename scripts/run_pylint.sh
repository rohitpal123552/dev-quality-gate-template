#!/bin/bash

# set -euo pipefail

REQUIRED_SCORE=9.0

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print() {
    echo -e "$@"
}

run_pylint() {
    print "${YELLOW}🔍 Running Pylint...${NC}"
    pylint_output=$(pylint sample_module/ || true)
    echo "$pylint_output"
    echo
    echo "${YELLOW}⚠️  Issues Found:${NC}"
    echo "$pylint_output" | grep -E "^.*:[0-9]+:[0-9]+: [A-Z][0-9]{4}:" || echo "No issues found."
    echo
}

check_score() {
    local score_line score

    score_line=$(echo "$pylint_output" | grep 'Your code has been rated at')
    score=$(echo "$score_line" | sed -E 's/.* ([0-9]+\.[0-9]+)\/10.*/\1/')

    if [[ -z "$score" ]]; then
        print "${RED}Could not determine pylint score.${NC}"
        exit 1
    fi

    print "${YELLOW}Pylint score: $score / 10${NC}"

    if (( $(echo "$score < $REQUIRED_SCORE" | bc -l) )); then
        print "${RED}❌ Pylint score too low: $score${NC}"
        exit 1
    else
        print "${GREEN}✅ Pylint score OK: $score${NC}"
    fi
}

main() {
    run_pylint
    check_score
}

main "$@"



























# #!/bin/bash

# # set -euo pipefail

# SOURCE_DIR="sample_module"
# REQUIRED_SCORE=8.0

# # ANSI Colors
# RED='\033[0;31m'
# GREEN='\033[0;32m'
# YELLOW='\033[1;33m'
# NC='\033[0m' # No Color

# print() {
#     echo -e "$@"
# }

# run_pylint() {
#     print "${YELLOW}🔍 Running Pylint on '${SOURCE_DIR}'...${NC}"
#     # pylint_output=$(pylint "$SOURCE_DIR" 2>&1 || true)
#     # Capture output using tee so it prints and can be processed
#     pylint_output=$(pylint sample_module/ 2>&1 | tee /dev/stderr)
#     echo "$pylint_output"
# }

# show_issues() {
#     print "\n${YELLOW} Issues Found:${NC}"
#     local issues
#     issues=$(echo "$1" | grep -E "^[^:]+:[0-9]+:[0-9]+:")

#     if [[ -n "$issues" ]]; then
#         echo "$issues" | while IFS= read -r line; do
#             print "${RED}$line${NC}"
#             exit 1
#         done
#     else
#         print "${GREEN}No syntax/style issues detected.${NC}"
#     fi
# }

# check_score() {
#     local score_line score
#     # Extract the score line
#     score_line=$(echo "$1" | grep "Your code has been rated at" || true)

#     if [[ -z "$score_line" ]]; then
#         print "${RED}Could not determine pylint score.${NC}"
#         exit 1
#     fi

#     # Extract only the first score (before /10)
#     score=$(echo "$score_line" | awk -F'at ' '{print $2}' | awk -F'/10' '{print $1}')

#     print "\nPylint score: $score / 10"

#     if (( $(echo "$score < $REQUIRED_SCORE" | bc -l) )); then
#         print "${RED}Pylint score too low: $score${NC}"
#         exit 1
#     else
#         print "${GREEN}Pylint score OK: $score${NC}"
#     fi
# }

# main() {
#     output=$(run_pylint)
#     show_issues "$output"
#     check_score "$output"
# }

# main "$@"
