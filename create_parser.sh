#!/usr/bin/env bash
set -euo pipefail

# Generate the parser Python files from the grammar on Unix-like systems.
# Usage: ./create_parser.sh
# Assume ANTLR is in path as 'antlr'

pushd "$(dirname "$0")/grammar" >/dev/null
antlr -Dlanguage=Python3 PythonSubset.g4
popd >/dev/null

echo "ANTLR generation complete (grammar/PythonSubset*.py written)."