#!/bin/bash

OBSIDIAN_VAULT_PATH="/Users/D1AX5TD/Documents/DATA/Obsidian/Obsidian Vault - Fakultät"
QUARTZ_CONTENT_PATH="/Users/D1AX5TD/Documents/Priv/thePeoplesMoney/QuartzBlog3/quartz/content"

echo "Beginne mit dem Kopieren..."

existing_files=()
for file in "$QUARTZ_CONTENT_PATH"/*.md; do
    if [ -e "$file" ]; then
        existing_files+=("$(basename "$file")")
    fi
done

IFS=$'\n'

for file in $(find "$OBSIDIAN_VAULT_PATH" -name "*.md"); do
    if grep -q "  - publish" "$file"; then
        if ! grep -q "^---" "$file"; then
            echo -e "---\ndraft: false\n---\n$(cat "$file")" > "$file"
        fi
        filename=$(basename "$file")
        target_file="$QUARTZ_CONTENT_PATH/$filename"
        cp "$file" "$target_file"
        existing_files=("${existing_files[@]/$filename}")

        # Bilder aus Obsidian kopieren
        image_references=$(grep -oE '\!\[\[([^]]+)\]\]' "$file" | sed -E 's/!\[\[([^]]+)\]\]/\1/g')

        if [ -z "$image_references" ]; then
            echo "Keine Bildreferenzen gefunden für: $file"
        else
            echo "Bildreferenzen gefunden: $image_references"
            
            for image_ref in $image_references; do
                # Entfernen Sie alles, was kein Dateiname ist (wenn es zusätzlichen Text gibt)
                image_filename=$(echo $image_ref | awk -F'/' '{print $NF}')
                # Fügen Sie .png hinzu, wenn es nicht bereits vorhanden ist
                [[ "$image_filename" != *".png" ]] && image_filename+=".png"
                image_path=$(dirname "$file")"/$image_filename"
                
                echo "Versuche, das Bild von $image_path zu kopieren..."
                
                if [ -e "$image_path" ]; then
                    cp "$image_path" "$QUARTZ_CONTENT_PATH"
                    echo "Bild erfolgreich kopiert: $image_ref"
                else
                    echo "Bildpfad existiert nicht: $image_path"
                fi
            done
        fi
    fi
done

for file in "${existing_files[@]}"; do
    if [ "$file" != "index.md" ] && [ -e "$QUARTZ_CONTENT_PATH/$file" ]; then
        rm "$QUARTZ_CONTENT_PATH/$file"
    fi
done

echo "Kopieren abgeschlossen."
