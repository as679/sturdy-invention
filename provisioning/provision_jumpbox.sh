#!/bin/bash -e

systemctl daemon-reload
systemctl enable squid
systemctl start squid
systemctl enable redis
systemctl start redis
chmod +x /usr/local/bin/handle_register.py
chmod +x /usr/local/bin/backup_user.py
systemctl enable handle_register
systemctl start handle_register
cp /usr/local/bin/register.py /usr/share/nginx/html/
systemctl enable nginx
systemctl start nginx