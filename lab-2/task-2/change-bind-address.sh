#!/bin/bash

CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"

# Проверка прав
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт от root (sudo)"
  exit 1
fi

# Обновление bind-address
sudo sed -i \
  's/^bind-address[ \t]*=[ \t]*127\.0\.0\.1$/bind-address = 192.168.50.11/' \
  "$CONFIG_FILE"

# Проверка результата
if [ $? -eq 0 ]; then
  echo "bind-address обновлён в $CONFIG_FILE"
else
  echo "Ошибка при обновлении bind-address"
  exit 1
fi

sudo systemctl restart mysql
