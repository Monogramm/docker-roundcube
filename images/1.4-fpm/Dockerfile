FROM roundcube/roundcubemail:1.4.x-fpm

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

# Add requirements for common extenions
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
        libgpgme11 \
        libgpgme11-dev \
        unzip \
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
            johndoh/contextmenu \
            sblaisot/automatic_addressbook \
            roundcube/carddav \
            texxasrulez/caldav_calendar \
            boressoft/ident_switch \
    ; \
    composer \
        --working-dir=/usr/src/roundcubemail/ \
        --prefer-dist --no-dev \
        --no-interaction \
        --optimize-autoloader --apcu-autoloader \
        update; \
    mv \
        /usr/src/roundcubemail/plugins/caldav_calendar/calendar \
        /usr/src/roundcubemail/plugins/caldav_calendar/libcalendaring \
        /usr/src/roundcubemail/plugins/ \
    ; \
    rm -rf \
        /usr/src/roundcubemail/plugins/caldav_calendar \
    ;

VOLUME /var/roundcube/keys
