FROM openresty/openresty:1.13.6.2-0-centos

RUN rm -f /etc/nginx/conf.d/*
ADD conf.d/app.conf /etc/nginx/conf.d/app.conf
CMD ["/usr/bin/openresty", "-g", "daemon off;"]
