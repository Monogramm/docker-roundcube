FROM roundcube/roundcubemail:elastic

LABEL maintainer="mathieu.brunot at monogramm dot io"

# Add requirements for common extenions
RUN set -ex; \
	apt-get update; \
	\
	apt-get install -y --no-install-recommends \
        libgpgme11 \
        libgpgme11-dev \
        wget \
	; \
	\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
    composer --version; \
	\
    pecl install gnupg; \
    \
	docker-php-ext-enable gnupg; \
    \
    composer install pear/net_sieve

VOLUME /var/roundcube/keys
