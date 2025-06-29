#!/bin/bash

echo "=== Create DB user ==="

# Rights verification
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script from root (sudo)."
  exit 1
fi

# SQL command
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

# Executing SQL from root via sudo
echo "$SQL_CMD" | sudo mysql -u root

# Checking the result
if [ $? -eq 0 ]; then
  echo "The database, table, and user have been successfully created."
else
  echo "Error when executing SQL commands."
  exit 1
fi
