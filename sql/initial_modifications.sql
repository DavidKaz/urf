update files2 set
f_datetime=STR_TO_DATE(s_date, '%Y:%m:%d %H:%i:%S') where s_date regexp '^[0-9]{4}:[0-9]{2}:[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$';

insert into raws2
(raw_path,raw_name,raw_date)
select distinct TRIM(TRAILING SUBSTRING_INDEX(file, '/', -1) from file),
SUBSTRING_INDEX(file, '/', -1),f_datetime from files2
where SUBSTRING_INDEX(file, '.', -1) in ('srw', 'orf', 'cr2', 'dng', 'dcr','raw','rw2','raf','nef');

update raws2 set raw_short_name = SUBSTRING_INDEX(raw_name, '.', 1);

insert into jpegs2
(jpeg_path,jpeg_name,jpeg_date)
select distinct TRIM(TRAILING SUBSTRING_INDEX(file, '/', -1) from file),
 SUBSTRING_INDEX(file, '/', -1),f_datetime from files2
 where SUBSTRING_INDEX(file, '.', -1) in ('jpg');

update jpegs2 set jpeg_short_name = SUBSTRING_INDEX(jpeg_name, '.', 1);

insert into  jpeg2_temp(jpeg_short_name, jpeg_date) select jpeg_short_name, jpeg_date from  jpegs2 union select fname,fdate from multiimages;


