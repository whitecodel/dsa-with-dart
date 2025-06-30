#!/bin/bash

# Temp directory for renaming
temp_dir="./temp_gist"
mkdir -p "$temp_dir"

# Find all .dart files recursively
find . -type f -name "*.dart" | while IFS= read -r dart_file; do
  echo "Processing: $dart_file"

  # Get original directory and base name
  dir_name=$(dirname "$dart_file")
  base_name=$(basename "$dart_file" .dart)
  txt_file="$dir_name/$base_name.txt"

  # Copy content to temp/main.dart
  cp "$dart_file" "$temp_dir/main.dart"

  if [[ -f "$txt_file" ]]; then
    # If .txt exists, extract Gist ID and update
    gist_url=$(cat "$txt_file")
    gist_id=$(basename "$gist_url")

    echo "🔁 Updating existing Gist: $gist_id"

    gh gist edit "$gist_id" --add "$temp_dir/main.dart" --desc "DSA with Dart" 2>/dev/null

    if [[ $? -eq 0 ]]; then
      echo "✅ Updated Gist: $gist_url"
    else
      echo "❌ Failed to update: $dart_file"
    fi
  else
    # Create public gist with file named main.dart
    new_gist_url=$(gh gist create "$temp_dir/main.dart" --public --desc "DSA with Dart" 2>/dev/null)

    if [[ $? -eq 0 && "$new_gist_url" == https://gist.github.com/* ]]; then
      echo "✅ Uploaded to: $new_gist_url"
      echo "$new_gist_url" > "$txt_file"
      echo "📝 Saved Gist URL to: $txt_file"
    else
      echo "❌ Failed to upload: $dart_file"
    fi
  fi

done

# Clean up
rm -rf "$temp_dir"
