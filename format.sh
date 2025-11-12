set -eo pipefail

function format_file() {
  local COMMENT_DISABLE_FORMATTER="-- +disable-pg-format"

  echo "Formatting SQL file $1"

  if grep -q -x -F -m 1 -- "$COMMENT_DISABLE_FORMATTER" "$1"; then
    echo "Skipping file $1 due to formatter disabled comment"

    return
  fi

  pg_format \
      --inplace \
      --keyword-case 2 \
      --function-case 2 \
      --type-case 2 \
      --keep-newline \
      --nogrouping \
      "$1"
}

echo "Formatting SQL scripts in $(pwd)"
find . -name '*.sql' -print | while IFS= read -r file; do
    format_file "$file"
done
