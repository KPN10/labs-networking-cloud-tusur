#!/bin/bash

echo "=== Write PHP code ==="

TARGET_FILE="/var/www/html/test_db.php"

# Rights verification
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script from root (sudo)."
  exit 1
fi

# Creating a PHP file
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

# Checking the result
if [ $? -eq 0 ]; then
  echo "The $TARGET_FILE file has been created successfully."
else
  echo "Error when creating the $TARGET_FILE."
  exit 1
fi
