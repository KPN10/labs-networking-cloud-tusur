#!/bin/bash

# Проверка запуска от root или через sudo
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт с sudo или от root"
  exit 1
fi

# SQL-команды
read -r -d '' SQL_CMD << 'EOF'
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
CREATE TABLE IF NOT EXISTS users (
  id INT,
  name VARCHAR(20)
);
INSERT INTO users VALUES (1, 'vagrant_test');
CREATE USER IF NOT EXISTS 'vagrant_test'@'192.168.50.10'
IDENTIFIED BY 'Tusur123';
GRANT ALL PRIVILEGES ON testdb.* TO 'vagrant_test'@'192.168.50.10';
FLUSH PRIVILEGES;
EOF

# Выполнение SQL от root через sudo
echo "$SQL_CMD" | sudo mysql -u root

# Проверка результата
if [ $? -eq 0 ]; then
  echo "База, таблица и пользователь успешно созданы."
else
  echo "Ошибка при выполнении SQL-команд."
  exit 1
fi
