# urf
unprocessed raw finder
the work is on progress

Для начала отредактировать файл etc/urf.conf :
переменная picsdir должна указывать на папку с фотографиями
1)Далее запускаем файл bin/1.sh
Должен создаться список файлов в папке с фотографиями var/files_old
2)Для следующего пункта нужна программа exiv2
Запустить bin/2.sh
Запустить bin/2.5.sh
Он там немного подчистит содержимое файла files2
Итого в папке var должно быть 2 файла files_old - список файлов и files2 - тот же список, но с датой из эксифа
