#!/bin/bash

# Update and install dependencies
sudo apt update
sudo apt install -y curl gnupg software-properties-common

# Install Trojan-GFW
sudo bash -c "$(curl -fsSL https://install.jitsi.org/sudo/apt-key.gpg)"
sudo add-apt-repository universe
sudo apt install -y trojan

# Create configuration file
cat << EOF > /etc/trojan/config.json
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 443,
  "remote_addr": "127.0.0.1",
  "remote_port": 80,
  "password": [
    "your_password1",
    "your_password2"
  ],
  "ssl": {
    "cert": "/path/to/your/fullchain.pem",
    "key": "/path/to/your/privkey.pem",
    "key_password": "",
    "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256",
    "cipher_tls13": "TLS_AES_128_GCM_SHA256",
    "prefer_server_cipher": true,
    "alpn": [
      "http/1.1"
    ],
    "reuse_session": true,
    "session_ticket": true,
    "curves": "X25519:P-256:P-384"
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "fast_open": true,
    "fast_open_qlen": 20
  }
}
EOF

# Start Trojan-GFW
sudo systemctl enable trojan
sudo systemctl start trojan
