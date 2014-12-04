update files2 
set 
    f_datetime = str_to_date(s_date, '%Y:%m:%d %H:%i:%S')
where
    s_date regexp '^[0-9]{4}:[0-9]{2}:[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'
        and f_datetime is null;
update files2 set f_datetime="0000-00-00 00:00:00" where substring_index(substring_index(file, '/', -1),'.',1) in (select raw_short_name from raws2 where raw_date="0000-00-00 00:00:00") and f_datetime is null;
 
