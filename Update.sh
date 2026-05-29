#!/bin/sh
# Update.sh - Code generator for update.sh

cat << 'EOF' > update.sh
#!/bin/bash
# Update.sh - Local Repository Index Compiler

dpkg-scanpackages -m debs > Packages
rm -f Packages.bz2 Packages.gz
bzip2 -k Packages
gzip -9fk Packages
echo "[V] Local repository indexes compiled successfully!"
EOF

# Make the generated script executable right away
chmod +x update.sh

echo "[V] update.sh script has been created successfully!"
