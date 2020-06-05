# Лабораторная работа №2
## Голотин Илья Олегович ББСО-02-18

### Задание 1 - Установка ОС, настройка LVM, RAID
Создаем виртуальную машину, выдав ей следующие характеристики:
1 gb ram 1 cpu 2 hdd - ssd1 и ssd2, с равным размером и возможностью горячей замены SATA контроллер настроен на 4 порта

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.1.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.2.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.3.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.4.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/RAID1.jpg)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.5.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.6.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.7.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.8.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.9.png)

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.10.png)

Команда `lsblk` - выдала информацию о состоянии дисков. 
С помощью команды `dd if=/dev/sda1 of=/dev/sdb1` я скопировал содержимое раздела /boot с диска sda на диск sdb.
Выполнил установку загрузчика ОС на второй диск с помощью `grub-install /dev/sdb`.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.11.png)

C помощью команды `cat /proc/mdstat` я ознакомился с информацией о текущем состоянии raid.
 `pvs` - выводит информацию о физической памяти
 `lvs` - выводит информацию о Logical Volume
 `vgs` - выводит информацию о группе томов LVM
Благодаря данному зданию я научился настраивать RAID, LVM, просматривать информацию о состояниях дисков и raid, устанавливать GRUB.

### Задание 2 - Эмуляция отказа одного из дисков

Команда просмотра состояния дисков `fdisk -l` после удаления диска ssd1 и перезагрузки  показала следующее:

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.12.png)

Результат отказа одного из дисков.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.13.png)

Создаю новый диск.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.14.png)

Синхронизация разделов с помощью `sfdisk -d /dev/sda | sfdisk /dev/sdb`
добавил новый диск в наш raid c помощью команды `mdadm --manage /dev/md0 --add /dev/sdb2`.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.16.png)

установка GRUB и копирования раздела /boot

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.17.png)

В этом задании узнал о командах
sfdisk -d /dev/XXXX | sfdisk /dev/YYY
mdadm --manage /dev/md0 --add /dev/YYY
Узнал как добавлять новый диск в систему и в raid


### Задание 3 - Добавление новых дисков и перенос раздела

Добавил новый диск большего объёма, скопировал файловую таблицу со старого диска на новый с помощью команды `sfdisk -d /dev/sda | sfdisk /dev/sdb`
скопировал данные /boot на новый диск

С помощью команды `mdadm --create --verbose /dev/md63 --force --level=1 --raid-devices=1 /dev/sdb2`  получилось создать новый рейд-массив только для нового ssd диска.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.19.png)

Теперь пришло время настроить LVM. Я создал новый физический том, включив в него ранее созданный RAID массив с помощью команды `pvcreate /dev/md63`.
Вывод информации о физических томах до и после выполнения данной команды:

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.20.png)

Чтобы увеличеть размер Volume Group system, использую команду `vgextend system /dev/md63`.
Переместил данные со старого диска на новый с помощью команды `pvmove -i 10 -n /dev/system/* /dev/md0 /dev/md63` 

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.21.png)

Удаляю диск старого raid из Volume Group с помощью команды `vgreduce system /dev/md0`, перемонтруем /boot и добавляем новые диски  При помощи `fsdisk` меняем объём раздела первого и второго диска.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.22.png)

Расширяю raid с помощью `pvresize /dev/md127`. 

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.23.png)

Добавляю VG var,root.

Создаём новый raid-массив, новое хранилище для логов и форматируем эти диски под ext4 с помощью `mkfs.ext4 /dev/mapper/data-var_log`.

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.24.png)

Переношу /var/log (пришлось останавливать процессы и синхронизировать разделы).

Измнение /etc/fstab

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.25.png)

Проверяем

![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.26.png)
![](https://github.com/AngerSkull/OS-labs/blob/master/lab2/screenshots/2.27.png)
