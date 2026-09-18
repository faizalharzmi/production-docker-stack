FROM php:8.4-fpm-alpine

RUN apk add --no-cache $PHPIZE_DEPS \
    && docker-php-ext-install pdo_mysql \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del $PHPIZE_DEPS

WORKDIR /var/www/html

COPY app/ /var/www/html/

RUN addgroup -g 1000 -S app \
    && adduser -u 1000 -S app -G app \
    && chown -R app:app /var/www/html

USER app

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=5 \
    CMD php -r '$s = @fsockopen("127.0.0.1", 9000); exit($s === false ? 1 : 0);'

CMD ["php-fpm", "-F"]
