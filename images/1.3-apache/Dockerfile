FROM roundcube/roundcubemail:1.3.8-apache

LABEL maintainer="mathieu.brunot at monogramm dot io"

# Add requirements for common extenions
RUN set -ex; \
	apt-get update; \
	\
	apt-get install -y --no-install-recommends \
        libgpgme11 \
        libgpgme11-dev \
	; \
	\
    pecl install gnupg; \
    \
	docker-php-ext-enable gnupg; \
    \
    pear install Net_Sieve

VOLUME /var/roundcube/keys
