. etc/urf.conf
mv var/files_new var/files_old
find $picsdir -type f | sort | sed "s@$picsdir/@@g" > var/files_new
