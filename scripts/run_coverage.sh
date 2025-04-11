#!/bin/bash

set -e

echo "🧪 Running tests with coverage..."
coverage run -m pytest
coverage report > coverage_output.txt
coverage_percent=$(grep -Eo '[0-9]+\%' coverage_output.txt | tail -1 | tr -d '%')
min_coverage=80

if (( coverage_percent < min_coverage )); then
    echo "❌ Code coverage too low: $coverage_percent% (min $min_coverage%)"
    cat coverage_output.txt
    exit 1
else
    echo "✅ Coverage passed: $coverage_percent%"
fi
