. etc/urf.conf
comm -3 var/files_new var/files_old |  grep -v "^urf/" | sed -r 's:\t+:deleting;:g' | while read in; do  if [[ $in == *deleting* ]]; then echo $in; else echo -n `exiv2 -qg Exif.Photo.DateTimeOriginal "$picsdir/$in" 2> /dev/null | awk '{print $(NF-1)" "$NF'}`;printf ";"; printf "$in"; printf "\n"; fi ; done > var/files2_buf
cat var/files2_buf 
