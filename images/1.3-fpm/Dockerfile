FROM roundcube/roundcubemail:1.3.8-fpm

LABEL maintainer="Mathieu BRUNOT <mathieu.brunot at monogramm dot io>"

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
    pear install Net_Sieve; \
    \
    pear install Net_LDAP3

VOLUME /var/roundcube/keys
