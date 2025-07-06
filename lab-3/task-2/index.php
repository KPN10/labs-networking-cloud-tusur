<?php
$mysqli = new mysqli(
  getenv('DB_HOST'),
  getenv('DB_USER'),
  getenv('DB_PASS')
);

if ($mysqli->connect_error) {
  die(' Error connection (' . $mysqli->connect_errno . ') ' . $mysqli->connect_error);
} else {
  echo "Connection successfully to MySQL";
}
?>
