. etc/urf.conf
if [ -f var/files_new ]; then
   mv var/files_new var/files_old 
fi
find $picsdir -type f | sort | sed "s@$picsdir/@@g" > var/files_new
