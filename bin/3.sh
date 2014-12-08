. etc/urf.conf
mv var/files_new var/files_old
find $picsdir -type f | sort > var/files_new
