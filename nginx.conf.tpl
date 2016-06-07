worker_processes auto;

events {
    worker_connections  1024;
}

{{ $ports := split $.Env.SERVICES_LB "," }}

{{ range $port := $ports }}
{{ range $service, $containers := groupByMulti $ "Env.SERVICES_CLIENT" "," }}
{{ if eq $port $service }}
# Load balance UDP-based DNS traffic across two servers
stream {
    upstream udp_{{$port}} {
      {{ range $container := $containers }}
        {{ range $address := $container.Addresses }}
                {{ if eq $address.Port $port }}
                # {{$container.Name}}
                server {{ $address.IP }}:{{ $address.Port }};
                {{ end }}
        {{ end }}
      {{ end }}
    }

    server {
        listen {{$port}} udp;
        proxy_pass udp_{{$port}};
        proxy_timeout 1s;
        proxy_responses 1;
        error_log dns.log;
    }
}
{{ end }}
{{ end }}
{{ end }}
