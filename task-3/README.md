# Задание 3: Shell - скрипт

Задание:

```
Напишите скрипт используя bash, который обеспечит:
- проверку состояния диска на занятый объем в процентах (можно любого диска или раздела в системе)
- если свободного объема менее 85% , отправит уведомление (алерт) на почту
- параметризацию настроек для адреса smtp сервера, логина и пароля к нему
Используйте любую удобную реализацию отправки почты через smtp (клиент на ваш выбор).
Для отравки почты используйте любой публичный smtp сервер, например вашей личной почты на yandex, mail, gmail.
Предоставьте результат в виде сценария, загруженного в проект на github
Не добавляйте в результат ваши личные данные для авторизации на smtp сервере!
```

- Для удобства разнес сам скрипт и нужные переменные на два файла, source'я второй в скрипте
- Отправку письма сделал используя утилиту msmtp; К сожалению не удалось до конца проверить ее работу (или любой иной утилиты), не справился с настройками smpt сервера.

script.sh:
```
#!/bin/bash

source config.sh

DISK_SPACE=$(df -h --total | grep total | awk '{print $5}' | sed 's/%//')

if [[ $DISK_SPACE -le $THRESHOLD ]]; then
    SUBJECT="Disk Space Alert: Disk is ${DISK_SPACE}% full"
    echo "$SUBJECT"
    MESSAGE="Warning: The disk usage on $DISK has reached ${DISK_SPACE}%."

    echo -e "Subject:$SUBJECT\n\n$MESSAGE" | msmtp --host=$SMTP_SERVER --port=$SMTP_PORT --auth=on --user=$SMTP_USER --password=$SMTP_PASS --from=$EMAIL_FROM -t $EMAIL_TO
fi
```

config.sh:
```
export THRESHOLD=85
export SMTP_SERVER="smpt.gmail.com"
export SMTP_PORT=587
export SMTP_USER="user"
export SMTP_PASS="password"
export EMAIL_FROM="example@gmail.com"
export EMAIL_TO="example2@gmail.com"
```


