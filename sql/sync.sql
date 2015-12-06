delete f2 . * from files2 f2
        inner join
    files2_buf f2b ON f2b.file = f2.file 
where
    f2b.s_date = 'deleting';

replace into files2 (file, s_date)
select f2b.file, f2b.s_date from files2_buf f2b where f2b.s_date!='deleting';


update files2 
set 
    f_datetime = str_to_date(s_date, '%Y:%m:%d %H:%i:%S')
where
    s_date regexp '^[0-9]{4}:[0-9]{2}:[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'
        and f_datetime is null;
update files2 set f_datetime="0000-00-00 00:00:00" where substring_index(substring_index(file, '/', -1),'.',1) in (select raw_short_name from raws2 where raw_date="0000-00-00 00:00:00") and f_datetime is null;

truncate table jpegs2;
truncate table raws2;
insert into raws2
(raw_path,raw_name,raw_date)
select distinct trim(trailing substring_index(file, '/', -1) from file),
 substring_index(file, '/', -1),f_datetime from files2
 where substring_index(file, '.', -1) in ('srw', 'orf', 'cr2', 'dng', 'dcr','raw','rw2','raf','nef','pef');
update raws2 
set raw_short_name = substring_index(raw_name, '.', 1);

insert into jpegs2
(jpeg_path,jpeg_name,jpeg_date)
select distinct trim(trailing substring_index(file, '/', -1) from file),
 substring_index(file, '/', -1),f_datetime from files2
 where substring_index(file, '.', -1) in ('jpg');
update jpegs2 
set jpeg_short_name = substring_index(jpeg_name, '.', 1); 

truncate table jpeg2_temp;

insert into  jpeg2_temp(jpeg_short_name, jpeg_date)
select jpeg_short_name, jpeg_date from  jpegs2 union select fname,fdate from multiimages;

select 
    count(*), raw_path
from
    raws2
where
    not exists( select 
            null
        from
            (select 
                jpeg_short_name, jpeg_date
            from
                jpeg2_temp) j
        where
            j.jpeg_short_name = raws2.raw_short_name
                and j.jpeg_date = raws2.raw_date)
        and raw_path not like '%window%'
        and raw_path not like '%papa%'
        and raw_path not like '%irina_d%'
group by raw_path
order by 1 desc;
