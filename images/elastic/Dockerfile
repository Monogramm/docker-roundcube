FROM roundcube/roundcubemail:elastic

LABEL maintainer="mathieu.brunot at monogramm dot io"

# Add requirements for common extenions
RUN set -ex; \
	apt-get update; \
	\
	apt-get install -y --no-install-recommends \
        libgpgme11 \
        libgpgme11-dev \
        php-net-sieve \
	; \
	\
    pecl install gnupg; \
    \
	docker-php-ext-enable gnupg;

VOLUME /var/roundcube/keys
