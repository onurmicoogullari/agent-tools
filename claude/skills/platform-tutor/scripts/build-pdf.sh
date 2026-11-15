#!/usr/bin/env bash
# Prints a primer's HTML file to an A4 PDF next to it with headless Chrome or
# Chromium. Usage: build-pdf.sh path/to/topic.html
set -euo pipefail

if [[ $# -ne 1 || ! -f "$1" ]]; then
  echo "usage: $0 path/to/topic.html" >&2
  exit 2
fi

html_path="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
pdf_path="${html_path%.html}.pdf"

chrome=""
for candidate in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  google-chrome google-chrome-stable chromium chromium-browser microsoft-edge; do
  if [[ -x "$candidate" ]] || command -v "$candidate" >/dev/null 2>&1; then
    chrome="$candidate"
    break
  fi
done

if [[ -z "$chrome" ]]; then
  echo "No Chrome, Chromium or Edge found. Open $html_path in a browser and print it to PDF." >&2
  exit 1
fi

# A throwaway profile keeps the print run from touching the user's browser
# profile or colliding with a Chrome window that is already open.
profile_dir="$(mktemp -d)"
trap 'rm -rf "$profile_dir"' EXIT

"$chrome" \
  --headless \
  --disable-gpu \
  --no-first-run \
  --user-data-dir="$profile_dir" \
  --no-pdf-header-footer \
  --print-to-pdf="$pdf_path" \
  "file://$html_path" >/dev/null 2>&1

echo "$pdf_path"
