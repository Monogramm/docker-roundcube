FROM roundcube/roundcubemail:1.4.x-apache

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

# Add requirements for common extenions
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
        libgpgme11 \
        libgpgme11-dev \
    ; \
    \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer; \
    mv \
        /usr/src/roundcubemail/composer.json-dist \
        /usr/src/roundcubemail/composer.json; \
    \
    pecl install gnupg; \
    docker-php-ext-enable gnupg; \
    \
    echo "\n" | pecl install apcu; \
    docker-php-ext-enable apcu; \
    \
    pear install Net_Sieve; \
    \
    composer \
        --working-dir=/usr/src/roundcubemail/ \
        --prefer-dist --prefer-stable \
        --no-update --no-interaction \
        --optimize-autoloader --apcu-autoloader \
        require \
            pear/net_ldap2 \
            kolab/net_ldap3 \
            mkopinsky/zxcvbn-php \
    ; \
    composer \
        --working-dir=/usr/src/roundcubemail/ \
        --prefer-dist --no-dev \
        --no-interaction \
        --optimize-autoloader --apcu-autoloader \
        update;

VOLUME /var/roundcube/keys
