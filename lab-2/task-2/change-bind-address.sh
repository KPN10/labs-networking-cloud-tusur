#!/bin/bash

echo "=== Change bind address ==="

CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"

# Right verification
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script from root (sudo)."
  exit 1
fi

# Bind-address update
sudo sed -i \
  's/^bind-address[ \t]*=[ \t]*127\.0\.0\.1$/bind-address = 192.168.50.11/' \
  "$CONFIG_FILE"

# Checking the result
if [ $? -eq 0 ]; then
  echo "The bind-address has been updated in the $CONFIG_FILE"
else
  echo "Error during execution."
  exit 1
fi

sudo systemctl restart mysql
