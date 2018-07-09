FROM openresty/openresty:1.13.6.2-0-centos

ADD conf.d/app.conf /etc/nginx/conf.d/app.conf
ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD src /usr/local/openresty/nginx/src
RUN opm install zmartzone/lua-resty-openidc
CMD ["/usr/bin/openresty", "-g", "daemon off;"]
