# urf
unprocessed raw finder
the work is in progress

* Скрипты предназначены для записи информации о файлах raw и jpg в базу данных mysql и дальнейшего поиска там "необработанных" raw файлов.

В настоящее время поиск ведётся на основании _имени_ файла и даты из exif.


Для использования на Windows надо установить cygwin, предоставляющий среду unix. Скачать установщик для своей версии windows можно тут https://cygwin.com/install.html

Список необходимых пакетов при работе в cygwin содержится в файле cygwin.packages


Также необходимо установить программу exiv2. Бинарная сборка с официального сайта программы не подойдёт, необходимо собрать вручную. Для этого надо скачать архив исходников в формате tar.gz со страницы http://www.exiv2.org/download.html. Далее распаковать его, например, 

`tar xvf exiv2-0.24.tar.gz` 

далее заходим в распакоанный каталог

`cd exiv2-0.24/`

собираем

`./configure`

`make`

и устанавливаем

`make install`


Для проверки работы натравим её на какой-нибудь файл фотографии

`exiv2 /cygdrive/c/tmp/dsc_0564.jpg`

Должно показать базовую информацию exif этого снимка


### Работа со скриптами:

Для начала отредактировать файл etc/urf.conf :
переменная picsdir должна указывать на папку с фотографиями

- Далее запускаем файл bin/1.sh
Должен создаться список файлов в папке с фотографиями var/files_old
- Для следующего пункта нужна программа exiv2
Запустить bin/2.sh
Запустить bin/2.5.sh
Он там немного подчистит содержимое файла files2
Итого в папке var должно быть 2 файла files_old - список файлов и files2 - тот же список, но с датой из эксифа

### Создание и первоначальное заполнение базы данных
- Скачать mariadb с http://ftp.mirror.yandex.ru/mirrors/mariadb/mariadb-10.0.15/winx64-packages/
или более новую версию
Следовать инструкции по установке
https://mariadb.com/kb/en/mariadb/documentation/getting-started/binary-packages/installing-mariadb-msi-packages-on-windows/
- Подключиться к серверу базы данных как пользователь root
mysql --host=127.0.0.1 -u root -p
Создать базу данных и пользователя для неё:
create database photos;
grant usage on photos.* to photos@localhost identified by 'photos';
grant all privileges on photos.* to photos@localhost identified by 'photos';
- Запустить второе окно shell (cygwin) и попробовать подключиться созданным пользователем к базе данных
mysql -h 127.0.0.1 -u photos -pphotos photos
Если зашло успешно, то набрать quit и запустить скрипт создания таблиц:
mysql -h 127.0.0.1 -u photos -pphotos photos < sql/create_tables.sql
- Загрузить данные из файла files2 в базу данных
mysqlimport -h 127.0.0.1 -d --user=photos --password=photos -c file,s_date --fields-terminated-by=";" --verbose --local photos var/files2

### Обновление базы

- Обновление списка файлов

`bin/3.sh`

- Данные exif по новым файлам
`bin/4.sh`

- Обновление данных в БД, вывод статистики на экран.
`bin/5.sh`
