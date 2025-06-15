
#!/bin/bash

# Check for fzf
if ! command -v fzf &> /dev/null; then
  echo "❌ fzf is required. Install it with: brew install fzf"
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $0 'YYYY-MM-DD HH:MM:SS'"
  exit 1
fi

INPUT_DATETIME="$1"

# List of timezones
TIMEZONES=($(ls /usr/share/zoneinfo/ | grep -v 'posix\|right' | xargs -I{} find /usr/share/zoneinfo/{} -type f | sed 's|/usr/share/zoneinfo/||'))

# Step 1: Select FROM timezone (default UTC)
FROM_TZ=$( (echo "UTC" && printf "%s\n" "${TIMEZONES[@]}") | fzf --prompt="From Timezone: ")

if [ -z "$FROM_TZ" ]; then
  echo "❌ No FROM timezone selected."
  exit 1
fi

# Step 2: Select TO timezone
TO_TZ=$(printf "%s\n" "${TIMEZONES[@]}" | fzf --prompt="To Timezone: ")

if [ -z "$TO_TZ" ]; then
  echo "❌ No TO timezone selected."
  exit 1
fi

# Convert using Python
CONVERTED=$(python3 -c "
from datetime import datetime
from zoneinfo import ZoneInfo
dt = datetime.strptime('$INPUT_DATETIME', '%Y-%m-%d %H:%M:%S').replace(tzinfo=ZoneInfo('$FROM_TZ'))
print(dt.astimezone(ZoneInfo('$TO_TZ')).strftime('%Y-%m-%d %H:%M:%S %Z'))
")

echo ""
echo "✅ Time Conversion"
echo "-------------------------------"
printf "%-15s | %s\n" "UTC" "$INPUT_DATETIME"
printf "%-15s | %s\n" "$TO_TZ" "$CONVERTED"
echo "-------------------------------"

