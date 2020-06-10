FROM php:5.6-alpine

ENV PATH "/composer/vendor/bin:$PATH"
ENV PHP_VERSION 5.6
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 1.10.7

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="php-$PHP_VERSION" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/soifou/composer"

RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
        git curl openssh openssl tini bash \
        libcurl curl-dev \
        libmcrypt-dev \
        icu-dev \
        libxml2-dev zlib-dev && \
    docker-php-ext-install \
        curl \
        ctype \
        iconv \
        json \
        mbstring \
        mcrypt \
        mysqli \
        pdo \
        pdo_mysql \
        posix \
        xml \
        zip

ADD ./composer.sh /composer.sh

RUN chmod u+x /composer.sh && \
    sh /composer.sh $COMPOSER_VERSION

RUN rm -rf /tmp/src && \
    rm -f /composer.sh \
    rm -rf /var/cache/apk/*

COPY php.ini /usr/local/etc/php/conf.d/50-setting.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]