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

inventory.ini:
```
[webservers]
127.0.0.1 ansible_port=3022 ansible_user=user ansible_password=12345
```

playbook.yaml:
```
- hosts: webservers
  become: yes
  become_user: root
  vars:
    nginx_user: nginx
    nginx_root: /usr/share/nginx/html
    nginx_index: index.html
    nginx_config_file: /etc/nginx/nginx.conf
    nginx_port: 80
    log_config:
      access_path: "/var/log/nginx/access.log"
      error_path: "/var/log/nginx/error.log"
  tasks:
    - name: Install nginx
      ansible.builtin.include_role:
        name: nginxinc.nginx

    - name: Copy Nginx configuration file
      template:
        src: nginx.conf.j2
        dest: "{{ nginx_config_file }}"
        mode: '0644'

    - name: Start nginx
      service:
        name: nginx
        state: started
        enabled: yes
```


Лог работы playbook'а находится в файле `ansible.log`
