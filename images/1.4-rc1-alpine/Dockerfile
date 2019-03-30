FROM monogramm/docker-roundcube-base:1.4-rc1-alpine

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

# Add requirements for common extenions (untested so far)
RUN set -ex; \
    apk add --no-cache \
        gpgme \
    ; \
	apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
        autoconf \
		gcc \
		g++ \
        gpgme-dev \
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
        --no-interaction --optimize-autoloader --apcu-autoloader; \
    \
	apk --purge del .build-deps

VOLUME /var/roundcube/keys
