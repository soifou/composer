FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="php-7.0" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/soifou/composer"

RUN apk add --no-cache --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
    wget \
    ca-certificates \
    git \
    openssh \
    php7 \
    php7-curl \
    php7-ctype \
    php7-dom \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-posix \
    php7-session \
    php7-zip \
    php7-zlib

RUN ln -s /usr/bin/php7 /usr/bin/php

COPY composer-installer /usr/local/bin/composer-installer
RUN cd /usr/local/bin && \
    chmod +x composer-installer && \
    sh composer-installer && \
    mv composer.phar composer && \
    rm composer-installer

COPY php.ini /etc/php7/conf.d/50-setting.ini

COPY composer-wrapper /usr/local/bin/composer-wrapper
RUN chmod +x /usr/local/bin/composer-wrapper

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /home/composer/.composer

WORKDIR /usr/src/app
VOLUME ["/home/composer/.composer"]
ENTRYPOINT ["/usr/local/bin/composer-wrapper"]
