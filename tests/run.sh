#!/usr/bin/env bash
# Formats tests/fixtures with the image and compares against tests/expected.
# Usage: tests/run.sh [image]   (default: opinionated-pg-formatter:test)
set -euo pipefail

cd "$(dirname "$0")/.."
image="${1:-opinionated-pg-formatter:test}"

work="$(mktemp -d "${TMPDIR:-/tmp}/pgf.XXXXXX")"
trap 'rm -rf "$work"' EXIT
cp tests/fixtures/*.sql "$work/"

docker run --rm -v "$work:/workdir" "$image"

diff -u tests/expected/input.sql "$work/input.sql"
# The file carrying the disable comment must stay untouched.
diff -u tests/fixtures/skipped.sql "$work/skipped.sql"
echo "OK"
