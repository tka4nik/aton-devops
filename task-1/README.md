# Задание 1: Ansible-playbook и Nginx

Задание:

```
Напишите ansible -плейбук, для конфигурации веб-сервера nginx 
- для выполнения задачи используйте подходящие модули ansible
- выбор операционной системы на ваше усмотрение
- плейбук должен устанавливать пакет nginx , настраивать его конфигурационный файл,
- производить запуск веб-сервера, проверять его доступность по 80 или 443 порту
- используйте параметры ( variables ) и шаблоны ( templates ) везде, где это возможно
- приложите скриншот или лог выполнения плейбука
- предоставьте результат в виде кода плейбука или всего проекта ansible , загруженного в проект на github
```

- Операционная система - RedHat Rocky Linux (minimal)
- Был использован template (и соответствующие переменные) для настройки конфига `nginx.conf`
- Для установки и настройки nginx был использован community collection [ansible-role-nginx](https://github.com/nginxinc/ansible-role-nginx)

Лог работы playbook'а находится в файле `ansible.log`