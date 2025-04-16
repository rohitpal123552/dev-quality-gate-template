#!/bin/bash

set -e

echo "🔍 Running Pylint..."
pylint_output=$(pylint sample_module/ || true)
echo $pylint_output
#echo "$pylint_output" > pylint_output.txt

# Try to parse the score line from the output
score_line=$(echo "$pylint_output" | grep 'Your code has been rated at')
score=$(echo "$score_line" | sed -E 's/.* ([0-9]+\.[0-9]+)\/10.*/\1/')
echo "score is $score"
required_score=8.0
if (( $(echo "$score < $required_score" | bc -l) )); then
    echo "❌ Pylint score too low: $score"
    exit 1
else
    echo "✅ Pylint score OK: $score"
fi
