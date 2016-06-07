

/usr/sbin/nginx
./docker-gen -watch -notify  "/usr/sbin/nginx -s reload" /etc/nginx/nginx.conf.tpl /etc/nginx/nginx.conf
