FROM alpine:3.12

ENV PATH "/composer/vendor/bin:$PATH"
ENV PHP_VERSION 8.0
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 2.0.11

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="php-$PHP_VERSION" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/soifou/composer"

ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN echo "https://dl.bintray.com/php-alpine/v3.12/php-$PHP_VERSION" >> /etc/apk/repositories && \
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
    php8 \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-gd \
    php8-iconv \
    php8-mbstring \
    php8-mongodb \
    php8-mysqli \
    php8-openssl \
    php8-pdo \
    php8-pdo_mysql \
    php8-phar \
    php8-posix \
    php8-session \
    php8-sodium \
    php8-xml \
    php8-zip \
    php8-zlib

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
