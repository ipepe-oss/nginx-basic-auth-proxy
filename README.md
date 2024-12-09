# Docker image of Nginx Proxy with Basic Auth

[![Docker Repository on Quay](https://quay.io/repository/dtan4/nginx-basic-auth-proxy/status "Docker Repository on Quay")](https://quay.io/repository/dtan4/nginx-basic-auth-proxy)

Simple HTTP Proxy with Basic Authentication

```
       w/ user:pass   +------------------------+      +-------------+
User ---------------> | nginx-basic-auth-proxy | ---> | HTTP Server |
                      +------------------------+      +-------------+
```

## Run

```bash
$ docker run \
    --rm \
    --name nginx-basic-auth-proxy \
    -p 8080:80 \
    -p 8090:8090 \
    -p 8443:443 \
    -e BASIC_AUTH_USERNAME=username \
    -e BASIC_AUTH_PASSWORD=password \
    -e PROXY_PASS=https://www.google.com \
    -e SERVER_NAME=proxy.dtan4.net \
    -e PORT=80 \
    -e SSL_CERT=/etc/nginx/ssl/nginx.crt \
    -e SSL_KEY=/etc/nginx/ssl/nginx.key \
    ipepe/nginx-basic-auth
```

Access to http://localhost:8080 , then browser asks you username and password.

You can also try complete HTTP-proxy example using Docker Compose.
hello-world web application cannot be accessed without authentication.

```bash
$ docker-compose up
# http://localhost:8080/
# - Username: username
# - Password: password
```

### Endpoint for monitoring

`:8090/nginx_status` returns the metrics of Nginx.

```sh-session
$ curl localhost:8090/nginx_status
Active connections: 1
server accepts handled requests
 8 8 8
Reading: 0 Writing: 1 Waiting: 0
```

## Environment variables

### Required

|Key|Description|
|---|---|
|`BASIC_AUTH_USERNAME`|Basic auth username|
|`BASIC_AUTH_PASSWORD`|Basic auth password|
|`PROXY_PASS`|Proxy destination URL|

### Optional

|Key|Description|Default|
|---|---|---|
|`SERVER_NAME`|Value for `server_name` directive|`example.com`|
|`PORT`|Value for `listen` directive|`80`|
|`CLIENT_MAX_BODY_SIZE`|Value for `client_max_body_size` directive|`1m`|
|`PROXY_READ_TIMEOUT`|Value for `proxy_read_timeout` directive|`60s`|
|`WORKER_PROCESSES`|Value for `worker_processes` directive|`auto`|
|`SSL_CERT`|Path to the SSL certificate|`/etc/nginx/ssl/nginx.crt`|
|`SSL_KEY`|Path to the SSL certificate key|`/etc/nginx/ssl/nginx.key`|

## Self-Signed Certificate

This Docker image generates a self-signed certificate during the build process. The certificate and key are stored in `/etc/nginx/ssl/nginx.crt` and `/etc/nginx/ssl/nginx.key` respectively.

To use the self-signed certificate, you can access the proxy via `https://localhost:8443`. Note that your browser will likely show a warning because the certificate is self-signed.

## Author

Daisuke Fujita ([@dtan4](https://github.com/dtan4))

## License

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
