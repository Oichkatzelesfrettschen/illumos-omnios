#!/usr/bin/env bash
##
# @file check_docs.sh
# @brief Generate documentation and measure coverage.
#
# This script runs Doxygen using the docs/Doxyfile configuration and
# captures all warnings emitted during the run. It also executes cloc to
# report on the amount of source code compared to documentation.
#
# Usage:
#   tools/check_docs.sh
##

set -euo pipefail

# Resolve repository root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DOXYFILE="$REPO_ROOT/docs/Doxyfile"
DOXY_DIR="$REPO_ROOT/docs/doxygen"
DOXY_WARN="$DOXY_DIR/warnings.log"
CLOC_REPORT="$DOXY_DIR/cloc_report.txt"

mkdir -p "$DOXY_DIR"

# Generate documentation and capture warnings
if doxygen "$DOXYFILE" 2>"$DOXY_WARN"; then
	echo "Doxygen run completed." >&2
else
	echo "Doxygen exited with errors." >&2
fi

# Summarize warnings
WARNINGS=$(grep -ci "warning" "$DOXY_WARN" || true)
if [ "$WARNINGS" -gt 0 ]; then
	echo "Found $WARNINGS Doxygen warnings:" >&2
	cat "$DOXY_WARN"
else
	echo "No Doxygen warnings." >&2
fi

# Measure code and documentation lines
cloc "$REPO_ROOT/usr/src" "$REPO_ROOT/docs" --quiet --csv --out "$CLOC_REPORT"

echo "Documentation coverage report:" >&2
cat "$CLOC_REPORT"
