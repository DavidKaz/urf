mysqlimport -h 127.0.0.1 -d --user=photos --password=photos -c s_date,file --fields-terminated-by=";" --verbose --local photos var/files2_buf
mysql -h 127.0.0.1 --user=photos --password=photos photos < sql/sync.sql
