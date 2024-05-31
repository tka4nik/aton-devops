# Задание 2: Docker Compose Nginx сервер

Задание:

```
Напишите dockerfile и docker compose для него, обеспечивающий запуск веб-севера nginx:
- dockerfile должен включать в себя добавление конфигурационного файла nginx
- конфигурационный файл nginx должен:
  - обеспечивать работу веб-сервера на 443 порту
  - использовать самоподписанный сертификат для доступа по https
  - иметь правило по умолчанию для редиректа с 80 на 443 порт
  - веб-сервер должен отдавать статическую html страницу с любым содержимым на ваш выбор
- В состав итогового docker образа ( image ) должны входить:
  - конфигурационный файл nginx
  - файл самоподписанного сертификата и его ключ
- Docker compose файл должен обеспечивать:
  - работу контейнера на основе собранного образа из dockerfile подговтоленного в прошлом шаге
  - автозапуск контейнера при рестарте операционной системы
  - статический html файл для nginx должен находиться на диске хоста и добавлен в контейнер как volume (из локальной директории или заранее созданного volume )
  - открытый порт для доступа к nginx с локального хоста
- предоставляемый результат должен включать в себя файлы, загруженные в проект на github:
  - dockerfile
  - docker-compose.yaml
  - самоподписанный сертификат и его ключ
  - статический html файл для nginx
  - скриншот или текстовой файл с результатами выполнения команды curl обращающегося к вашему nginx , запущенному в контейнере (например: curl -vk https://localhost:443) 
```

- self-signed ssl сертификат делал по [этой](https://mpolinowski.github.io/docs/DevOps/NGINX/2020-08-27--nginx-docker-ssl-certs-self-signed/2020-08-27/) инструкции.
  
Dockerfile:
```
FROM nginx:1.25.5

COPY cert/nginx.crt /etc/nginx/ssl/nginx.crt
COPY cert/nginx.key /etc/nginx/ssl/nginx.key

COPY nginx.conf /etc/nginx/nginx.conf
```

docker-compose.yaml:
```
services:
  nginx:
    build: .
    ports:
      - 80:80
      - 443:443
    volumes:
      - ./index.html:/usr/share/nginx/html/index.html
```

![image](https://github.com/tka4nik/aton-devops/assets/39916647/98fcfb2c-4cb0-4ab6-a86a-71cf9d7f4aa8)
![image](https://github.com/tka4nik/aton-devops/assets/39916647/42046290-82e7-4bbb-bc70-8e042ed4612d)



