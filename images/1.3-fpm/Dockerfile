FROM roundcube/roundcubemail:1.3.8-fpm

LABEL maintainer="mathieu.brunot at monogramm dot io"

# Add requirements for common extenions
RUN set -ex; \
	apt-get update; \
	\
	apt-get install -y --no-install-recommends \
        composer \
        libgpgme11 \
        libgpgme11-dev \
        wget \
	; \
	\
    pecl install gnupg; \
    \
	docker-php-ext-enable gnupg; \
    \
    composer install pear/net_sieve

VOLUME /var/roundcube/keys
