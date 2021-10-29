FROM nginx:1.21.3
RUN usermod -u 1089 nginx \
    && groupmod -g 1090 nginx \
    && chown -R nginx:nginx /usr/share/nginx
