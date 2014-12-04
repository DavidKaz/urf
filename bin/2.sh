cat var/files_old | while read in; do printf "$in";printf ";"; echo -n `exiv2 -qg Exif.Photo.DateTimeOriginal "$in" 2> /dev/null | awk '{print $(NF-1)" "$NF'}`; printf "\n" ; done > var/files2
