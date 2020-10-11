FROM dotriver/alpine-s6

ENV DATABASE_HOST=localhost \
    DATABASE_PORT=3306 \
    DATABASE_PASSWORD=password \
    DATABASE_USERNAME=username \
    DATABASE_NAME=nextcloud \
    ADMIN_USERNAME=admin \
    ADMIN_PASSWORD=password \
    TRUSTED_DOMAIN_0=localhost 

RUN set -x \
    && apk --no-cache add curl php7 php7-fpm php7-gd php7-intl php7-ldap php7-memcached php7-pcntl php7-pdo php7-zip php7-mbstring php7-dom php7-xmlwriter php7-xmlreader php7-xml php7-ctype php7-json php7-iconv php7-simplexml php7-curl php7-pdo_mysql php7-posix php7-cli php7-mcrypt php7-opcache php7-fileinfo php7-imagick php7-gmp php7-bcmath memcached 

RUN set -x \
    && apk --no-cache add nginx mysql-client \
    && mkdir -p /run/nginx/ \
    && rm -R /var/www/* || true \
    && chown nginx:nginx /var/www/ /run/nginx/


RUN set -x \
    && rm /etc/nginx/conf.d/* \
    && rm /etc/php7/php-fpm.d/* 

ADD conf/ /

RUN set -x \
    && chmod +x /etc/cont-init.d/ -R \
    && chmod +x /etc/periodic/ -R  \
    && chmod +x /etc/s6/services/ -R 

