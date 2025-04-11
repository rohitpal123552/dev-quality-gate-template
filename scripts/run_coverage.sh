#!/bin/bash

set -e

echo "🧪 Running tests with coverage..."
coverage run -m pytest
coverage_percent=$(coverage report | grep TOTAL | awk '{print $4}' | sed 's/%//')

required_coverage=80
if (( $(echo "$coverage_percent < $required_coverage" | bc -l) )); then
    echo "❌ Test coverage too low: $coverage_percent%"
    exit 1
else
    echo "✅ Test coverage OK: $coverage_percent%"
fi

