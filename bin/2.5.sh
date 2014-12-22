. etc/urf.conf
sed "s@$picsdir/@@g" var/files2 > var/files2_temp
cat var/files2_temp | grep -v "urf/" > var/files2
