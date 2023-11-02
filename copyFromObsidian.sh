#!/bin/bash

OBSIDIAN_VAULT_PATH="/Users/D1AX5TD/Documents/DATA/Obsidian/Obsidian Vault - Fakultät"
QUARTZ_CONTENT_PATH="/Users/D1AX5TD/Documents/Priv/thePeoplesMoney/QuartzBlog3/quartz/content"

# Funktion zum Umwandeln von Obsidian-Bildlinks in normale Markdown-Bildlinks
convert_obsidian_links() {
    local file="$1"
    sed -i '' -e 's/!\[\[Pasted image \(.*\)\.png\]\]/![Bild](\1.png)/g' "$file"
}

# Erstelle eine Liste von Dateien in Quartz, um sie später mit den Obsidian-Dateien zu vergleichen.
existing_files=()
for file in "$QUARTZ_CONTENT_PATH"/*.md; do
    if [ -e "$file" ]; then # Überprüfen, ob die Datei existiert
        existing_files+=("$(basename "$file")")
    fi
done

# Ändern des internen Feldseparators, um nur Zeilenumbrüche als Trennzeichen zu verwenden
IFS=$'\n'

# Durchlaufen Sie jede Markdown-Datei im Obsidian-Ordner und seinen Unterverzeichnissen.
for file in $(find "$OBSIDIAN_VAULT_PATH" -name "*.md"); do
    if grep -q "  - publish" "$file"; then
        # Überprüfen Sie, ob der Frontmatter existiert
        if ! grep -q "^---" "$file"; then
            # Fügen Sie Frontmatter hinzu, wenn er fehlt
            echo -e "---\ndraft: false\n---\n$(cat "$file")" > "$file"
        fi
        # Konvertiere Obsidian Bildlinks
        convert_obsidian_links "$file"
        # Kopieren Sie die Datei zu Quartz
        cp "$file" "$QUARTZ_CONTENT_PATH"
        # Entfernen Sie die Datei aus der Liste der vorhandenen Dateien, da sie aktualisiert oder hinzugefügt wurde.
        existing_files=("${existing_files[@]/$(basename "$file")}")
    fi
done

# Löschen Sie Dateien aus Quartz, die nicht in Obsidian sind, außer der index.md.
for file in "${existing_files[@]}"; do
    if [ "$file" != "index.md" ] && [ -e "$QUARTZ_CONTENT_PATH/$file" ]; then # Überprüfen, ob die Datei existiert und nicht "index.md" ist
        rm "$QUARTZ_CONTENT_PATH/$file"
    fi
done
