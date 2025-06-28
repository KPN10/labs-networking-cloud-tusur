#!/bin/bash

CFG_FILE="/etc/haproxy/haproxy.cfg"

# Проверка наличия прав root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт от root (sudo)"
  exit 1
fi

# Конфигурационный блок
read -r -d '' BLOCK << EOF
frontend http_front
  bind *:80
  default_backend http_back

backend http_back
  balance roundrobin
  server webserver1 192.168.50.10:80 check inter 5000 rise 2 fall 3
EOF

# Строка для проверки наличия блока (по frontend + backend)
if grep -q "frontend http_front" "$CFG_FILE" && \
   grep -q "backend http_back" "$CFG_FILE"; then
  echo "Конфигурационный блок уже присутствует в $CFG_FILE. Добавление не требуется."
  exit 0
fi

# Добавление блока в конец файла
echo "$BLOCK" >> "$CFG_FILE"

# Проверка результата
if [ $? -eq 0 ]; then
  echo "Конфигурация успешно добавлена в $CFG_FILE"
else
  echo "Ошибка при добавлении конфигурации"
  exit 2
fi

sudo systemctl restart haproxy
