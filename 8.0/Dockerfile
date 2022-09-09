FROM alpine:3.14

ENV PATH "/composer/vendor/bin:$PATH"
ENV PHP_VERSION 8.0
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 2.4.1

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="php-$PHP_VERSION" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/soifou/composer"

RUN ALPINE_VERSION=`cat /etc/alpine-release | cut -d'.' -f-2` && \
    wget -O /etc/apk/keys/php-alpine.rsa.pub https://php.hernandev.com/key/php-alpine.rsa.pub && \
    echo "https://php.hernandev.com/v$ALPINE_VERSION/php-$PHP_VERSION" >> /etc/apk/repositories && \
    apk add --update --no-cache \
    ca-certificates \
    bash \
    curl \
    less \
    tini \
    git \
    openssh \
    openssl \
    mariadb-client \
    php \
    php-ctype \
    php-curl \
    php-dom \
    php-gd \
    php-iconv \
    php-mbstring \
    php-mongodb \
    php-mysqli \
    php-openssl \
    php-pdo \
    php-pdo_mysql \
    php-phar \
    php-posix \
    php-session \
    php-sodium \
    php-xml \
    php-zip \
    php-zlib

RUN ln -sf /usr/bin/php8 /usr/bin/php

ADD ./composer.sh /composer.sh
RUN chmod u+x /composer.sh && \
    sh /composer.sh $COMPOSER_VERSION

RUN rm -rf /tmp/src && \
    rm -f /composer.sh \
    rm -rf /var/cache/*

COPY php.ini /etc/php8/conf.d/50_custom.ini

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]
