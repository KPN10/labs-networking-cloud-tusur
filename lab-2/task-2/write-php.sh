#!/bin/bash

TARGET_FILE="/var/www/html/test_db.php"

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт с sudo или от имени root"
  exit 1
fi

# Создание PHP-файла
cat << 'EOF' > "$TARGET_FILE"
<?php
$host = "192.168.50.11";
$user = "vagrant_test";
$pass = "Tusur123";
$db   = "testdb";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

echo "Connected to MySQL successfully!";
?>
EOF

# Проверка результата
if [ $? -eq 0 ]; then
  echo "Файл $TARGET_FILE успешно создан."
else
  echo "Ошибка при создании файла $TARGET_FILE."
  exit 1
fi
