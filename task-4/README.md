# Задание 4*: CI/CD Pipeline

[https://gitlab.com/tka4nik/aton-cicd](https://gitlab.com/tka4nik/aton-cicd)

Задание:

```
Напишите пайплайн для сборки и доставки приложения ( CI/CD ).
Вы можете использовать любую из возможных и доступных вам CI систем.
Публичные сервисы типа GitHub (GitHub Actions) или GitLab представляют свои инструменты бесплатно, их возможностей должно быть достаточно для выполнения данной задачи.

Этапы пайплайна (сборка и доставка) могуть быть реализованы в любом удобном для вас формате:
- сценарий bash
- ansible плейбук
- любые профильные инструменты предназначенные для подобных задач

Этап сборки ( CI ) должен включать в себя создание docker контейнера (можно использовать результат из задания 2).
Этап доставки ( CD ) должен обеспечивать запуск приложения из созданного docker контейнера.
Предоставьте результат в виде сценариев (пайплайнов) и результата их выполнения (в виде скриншотов или лога выполненных этапов пайплайна), загруженных в проект на github.
```

- Платформа - Gitlab CI/CD (имею бОльший опыт работы на ней), ссылка в виде [подмодуля](https://gitlab.com/tka4nik/aton-cicd)
- Этапы pipeline'а выполнены в формате bash-сценариев
- Перый этап собирает docker-container из задания №2, а второй обновляет и запускает его
  - Вместо docker hub как container registry выбрал registry.gitlab.com из-за [некоторых недавних событий](https://habr.com/ru/news/818177/)
  - //*Работает нормально кстати, надо другие свои проекты перетащить туда*//
  - Использовал dind сервис для работы с докером изнутри докера
  - Пароль и логин храню как маскированные переменные в gitlab
    
 
![image](https://github.com/tka4nik/aton-devops/assets/39916647/d6597d88-4675-4a87-b642-c1fd3a6fc9aa)
![image](https://github.com/tka4nik/aton-devops/assets/39916647/dc47a7e5-d5b1-4031-88f4-ce8ae0613035)
![image](https://github.com/tka4nik/aton-devops/assets/39916647/28630b0a-ba31-4062-980f-a8ba461d203d)
![image](https://github.com/tka4nik/aton-devops/assets/39916647/f06e9589-1591-4709-a101-f459506bb519)


.gitlab-ci.yml:
```
image: docker:latest

stages:
  - build
  - deploy

services:
  - docker:dind

variables:
  DOCKER_IMAGE: aton-cicd
  DOCKER_REGISTRY: registry.gitlab.com

before_script:
  - docker login $DOCKER_REGISTRY -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

build:
  stage: build
  only:
    - main
  script:
    - docker build -t $DOCKER_IMAGE:latest .
    - docker tag $DOCKER_IMAGE:latest $DOCKER_REGISTRY/$DOCKER_USERNAME/$DOCKER_IMAGE:latest
    - docker push $DOCKER_REGISTRY/$DOCKER_USERNAME/$DOCKER_IMAGE:latest

deploy:
  stage: deploy
  only:
    - main
  script:
    - docker compose pull
    - docker compose up -d
```


