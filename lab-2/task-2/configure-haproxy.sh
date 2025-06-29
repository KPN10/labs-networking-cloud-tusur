#!/bin/bash

echo "=== Configure haproxy ==="

CFG_FILE="/etc/haproxy/haproxy.cfg"

# Rights verification
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script from root (sudo)."
  exit 1
fi

# Confiburation block
read -r -d '' BLOCK << EOF
frontend http_front
  bind *:80
  default_backend http_back

backend http_back
  balance roundrobin
  server webserver1 192.168.50.10:80 check inter 5000 rise 2 fall 3
EOF

# Line for checking the block availability (by frontend + backend)
if grep -q "frontend http_front" "$CFG_FILE" && \
   grep -q "backend http_back" "$CFG_FILE"; then
  echo "The configuration block is already present in the $CFG_FILE.\
No addition is required."
  exit 0
fi

# Adding a block to the end of the file
echo "$BLOCK" >> "$CFG_FILE"

# Checking the result
if [ $? -eq 0 ]; then
  echo "The configuration has been successfully added to $CFG_FILE."
else
  echo "Error when adding configuration."
  exit 2
fi

sudo systemctl restart haproxy
