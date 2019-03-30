FROM monogramm/docker-roundcube-base:1.4-rc1-fpm

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

# Add requirements for common extenions
RUN set -ex; \
    apt-get update; \
    \
    apt-get install -y --no-install-recommends \
        libgpgme11 \
        libgpgme11-dev \
    ; \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer; \
    \
    pecl install gnupg; \
    echo "\n" | pecl install apcu; \
    \
    docker-php-ext-enable gnupg; \
    docker-php-ext-enable apcu; \
    \
    pear install Net_Sieve; \
    \
    composer require pear/net_ldap2 kolab/net_ldap3 mkopinsky/zxcvbn-php \
        --prefer-dist --prefer-stable --update-no-dev \
        --no-interaction --optimize-autoloader --apcu-autoloader

VOLUME /var/roundcube/keys
