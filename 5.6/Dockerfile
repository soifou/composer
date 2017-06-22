FROM php:5.6-alpine

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="php-5.6" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-url="https://github.com/soifou/composer"

ENV PATH "/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 1.4.2

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
        zip && \
    rm -fr /var/cache/apk/*

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer \
 && php -r " \
    \$signature = '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && rm /tmp/installer.php \
 && composer --ansi --version --no-interaction

COPY php.ini /usr/local/etc/php/conf.d/50-setting.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["composer"]