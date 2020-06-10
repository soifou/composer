FROM alpine:3.5

ENV PATH "/composer/vendor/bin:$PATH"
ENV PHP_VERSION 7.0
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 1.10.7

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="php-$PHP_VERSION" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/soifou/composer"

RUN apk add --update --no-cache \
    bash \
    curl \
    less \
    tini \
    git \
    openssh \
    openssl \
    mariadb-client \
    php7 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-gd \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqli \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-posix \
    php7-session \
    php7-xml \
    php7-zip \
    php7-zlib

RUN ln -sf /usr/bin/php7 /usr/bin/php

ADD ./composer.sh /composer.sh
RUN chmod u+x /composer.sh && \
    sh /composer.sh $COMPOSER_VERSION

RUN rm -rf /tmp/src && \
    rm -f /composer.sh \
    rm -rf /var/cache/apk/*

COPY php.ini /etc/php7/conf.d/50_custom.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]