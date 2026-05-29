#!/bin/sh
# Packages.sh - Interactive Packages File Generator

if [ ! -d "debs" ] || [ -z "$(ls debs/*.deb 2>/dev/null)" ]; then
    echo "Error: No .deb files found inside the /debs/ directory."
    exit 1
fi

rm -f Packages
echo "Scanning debs directory..."

for deb in debs/*.deb; do
    echo "-----------------------------------------"
    echo "Detected file: $deb"
    
    # Extract internal control elements from binary
    PKG_ID=$(dpkg-deb -f "$deb" Package)
    PKG_NAME=$(dpkg-deb -f "$deb" Name)
    PKG_VER=$(dpkg-deb -f "$deb" Version)
    PKG_ARCH=$(dpkg-deb -f "$deb" Architecture)
    PKG_DESC=$(dpkg-deb -f "$deb" Description)
    
    echo "Package ID: $PKG_ID"
    echo "Package Name: $PKG_NAME"
    echo "Version: $PKG_VER"
    
    printf "Maintainer (email required): "
    read MAINTAINER
    printf "Author (email required): "
    read AUTHOR
    
    # Compute Hash Values
    SIZE=$(wc -c < "$deb" | tr -d ' ')
    MD5=$(md5sum "$deb" | cut -d' ' -f1)
    SHA1=$(sha1sum "$deb" | cut -d' ' -f1)
    SHA256=$(sha256sum "$deb" | cut -d' ' -f1)
    
    # Write cleanly to Packages database
    echo "Package: $PKG_ID" >> Packages
    echo "Name: $PKG_NAME" >> Packages
    echo "Version: $PKG_VER" >> Packages
    echo "Architecture: $PKG_ARCH" >> Packages
    echo "Maintainer: $MAINTAINER" >> Packages
    echo "Author: $AUTHOR" >> Packages
    echo "Filename: $deb" >> Packages
    echo "Size: $SIZE" >> Packages
    echo "MD5sum: $MD5" >> Packages
    echo "SHA1: $SHA1" >> Packages
    echo "SHA256: $SHA256" >> Packages
    echo "Description: $PKG_DESC" >> Packages
    echo "" >> Packages # Mandatory separator line
done

echo "========================================="
echo "Package Finished"
echo "========================================="
printf "Press ENTER to continue..."
read pause
