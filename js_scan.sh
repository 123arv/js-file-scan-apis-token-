# Make sure js.txt exists
if [ ! -f js.txt ]; then
  echo "[-] js.txt file not found!"
  exit 1
fi

# Make output directory
mkdir -p js_dump

# Loop through each URL
while read -r url; do
  echo "[*] Downloading: $url"
  filename=$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g')  # Clean filename
  curl -s "$url" -o "js_dump/$filename.js"

  echo "[*] Scanning: $filename.js"
  grep -Eoi '(api[_-]?key|secret|token|auth|bearer)[\"'\''\s:=]{0,10}[\"'\''A-Za-z0-9_\-]{10,}' "js_dump/$filename.js"

done < js.txt
