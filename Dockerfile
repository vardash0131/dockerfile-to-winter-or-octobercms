FROM gcr.io/google-appengine/php73
 
ARG COMPOSER_FLAGS='--prefer-dist'
ENV COMPOSER_FLAGS=${COMPOSER_FLAGS}
ENV SWOOLE_VERSION=4.3.4
ENV DOCUMENT_ROOT=/app
 
COPY . $APP_DIR


RUN apt-get update -y \
&& apt-get install -y \
unzip \
autoconf \
build-essential \
libmpdec-dev \
libpq-dev \
&& pecl install decimal \
&& curl -o /tmp/swoole.tar.gz https://github.com/swoole/swoole-src/archive/v$SWOOLE_VERSION.tar.gz -L \
&& tar zxvf /tmp/swoole.tar.gz \
&& cd swoole-src* \
&& phpize \
&& ./configure \
--enable-async-redis \
&& make \
&& make install \
&& chown -R www-data.www-data $APP_DIR \
&& /build-scripts/composer.sh \
&& mv $APP_DIR/storage $APP_DIR/storagestatic \
&& ln -s /tmp $APP_DIR/storage \
&& cp -TRv $APP_DIR/storagestatic/ $APP_DIR/storage/ \
&& chown -R www-data.www-data $APP_DIR/storage \
&& chmod -R 777 $APP_DIR/storage ;
RUN chmod -R 777 $APP_DIR/vendor ;

ENTRYPOINT ["/build-scripts/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]


EXPOSE 8080