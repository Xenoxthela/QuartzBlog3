#!/bin/bash

OBSIDIAN_VAULT_PATH="/Users/D1AX5TD/Documents/DATA/Obsidian/Obsidian Vault - Fakultät"
QUARTZ_CONTENT_PATH="/Users/D1AX5TD/Documents/Priv/thePeoplesMoney/QuartzBlog3/quartz/content"

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



# #!/bin/bash

# OBSIDIAN_VAULT_PATH="/Users/D1AX5TD/Documents/DATA/Obsidian/Obsidian Vault - Fakultät/Fakultät/Full Stack Developer"
# QUARTZ_CONTENT_PATH="/Users/D1AX5TD/Documents/Priv/thePeoplesMoney/QuartzBlog3/quartz/content/"

# # Löscht alle vorhandenen Markdown-Dateien im Quartz-Verzeichnis
# rm "$QUARTZ_CONTENT_PATH"/*.md

# # Durchsucht alle Markdown-Dateien im Obsidian-Verzeichnis
# for file in "$OBSIDIAN_VAULT_PATH"/*.md; do
#     # Überprüft, ob der Tag "publish" in der Datei vorhanden ist
#     if grep -q "  - publish" "$file"; then
#         # Kopiert die Datei nach Quartz
#         cp "$file" "$QUARTZ_CONTENT_PATH"
#     fi
# done





# #!/bin/bash

# OBSIDIAN_VAULT_PATH="/Users/D1AX5TD/Documents/DATA/Obsidian/Obsidian Vault - Fakultät"
# QUARTZ_CONTENT_PATH="/Users/D1AX5TD/Documents/Priv/thePeoplesMoney/QuartzBlog3/quartz/content"

# # Erstelle eine Liste von Dateien in Quartz, um sie später mit den Obsidian-Dateien zu vergleichen.
# existing_files=()
# for file in "$QUARTZ_CONTENT_PATH"/*.md; do
#     if [ -e "$file" ]; then # Überprüfen, ob die Datei existiert
#         existing_files+=("$(basename "$file")")
#     fi
# done

# # Durchlaufen Sie jede Markdown-Datei im Obsidian-Ordner.
# for file in "$OBSIDIAN_VAULT_PATH"/*.md; do
#     if grep -q "  - publish" "$file"; then
#         # Überprüfen Sie, ob der Frontmatter existiert
#         if ! grep -q "^---" "$file"; then
#             # Fügen Sie Frontmatter hinzu, wenn er fehlt
#             echo -e "---\ndraft: false\n---\n$(cat "$file")" > "$file"
#         fi
#         # Kopieren Sie die Datei zu Quartz
#         cp "$file" "$QUARTZ_CONTENT_PATH"
#         # Entfernen Sie die Datei aus der Liste der vorhandenen Dateien, da sie aktualisiert oder hinzugefügt wurde.
#         existing_files=("${existing_files[@]/$(basename "$file")}")
#     fi
# done

# # Löschen Sie Dateien aus Quartz, die nicht in Obsidian sind.
# for file in "${existing_files[@]}"; do
#     if [ -e "$QUARTZ_CONTENT_PATH/$file" ]; then # Überprüfen, ob die Datei existiert
#         rm "$QUARTZ_CONTENT_PATH/$file"
#     fi
# done
