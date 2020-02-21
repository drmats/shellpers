# nginx with php

## install what's needed
```
# dnf install nginx php-fpm
```

## configure
* `/etc/php.ini`:
    ```
    ...
    short_open_tag = On
    ...
    cgi.fix_pathinfo=0
    ...
    ```

* `/etc/php-fpm.d/www.conf`:
    ```
    ...
    user = nginx
    group = nginx
    ...
    listen.owner = nginx
    listen.group = nginx
    ...
    ```

## run php daemon
```
# systemctl start php-fpm
# systemctl enable php-fpm
# systemctl status php-fpm
```

## example nginx config
```
server {
    listen          80;
    listen          [::]:80;
    server_name     example.com;

    access_log      /path/to/access.log main;
    error_log       /path/to/error.log error;

    root            /path/to/webroot;

    gzip            on;
    gzip_comp_level 3;
    gzip_types      text/plain text/css application/javascript image/*;

    error_page      403 404 /404.html;
    error_page      500 502 503 503 /50x.html;

    if ($host != example.com ) {
        rewrite ^/(.*)$ http://example.com/$1 permanent;
    }

    location / {
        autoindex on;
        try_files $uri $uri/ /index.php =404;
        index     index.php index.html;
    }

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;

        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }

        fastcgi_param HTTP_PROXY "";
        fastcgi_pass  php-fpm;
        fastcgi_index index.php;
        include       fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param SCRIPT_NAME $fastcgi_script_name;
    }
}
```


## run nginx
```
# systemctl start nginx
# systemctl enable nginx
# systemctl status nginx
```
