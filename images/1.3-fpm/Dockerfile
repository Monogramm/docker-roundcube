FROM roundcube/roundcubemail:1.3.8-fpm

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
    pecl install gnupg; \
    \
	docker-php-ext-enable gnupg; \
    \
    wget -O /tmp/Net_Sieve_1.4.4.tar.gz https://github.com/pear/Net_Sieve/archive/1.4.4.tar.gz; \
    pear install /tmp/Net_Sieve_1.4.4.tar.gz; \
    rm -f /tmp/Net_Sieve_1.4.4.tar.gz

VOLUME /var/roundcube/keys
