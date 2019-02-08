FROM roundcube/roundcubemail:elastic

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
    echo 'PEAR is currently down, so Net_Sieve cannot be installed!!'
    #pear install Net_Sieve

VOLUME /var/roundcube/keys
