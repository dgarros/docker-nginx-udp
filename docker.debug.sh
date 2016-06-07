


docker run --rm -t  \
      -p 6000:6000/udp \
      -e SERVICES_LB="6000" \
      -v /var/run/docker.sock:/tmp/docker.sock:ro \
      -v $(pwd)/nginx.conf.tpl:/etc/nginx/nginx.conf.tpl:ro \
      -v /var/run/docker.sock:/tmp/docker.sock:ro \
      -i dgarros/nginx-udp
