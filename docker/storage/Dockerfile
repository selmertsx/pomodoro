FROM busybox

RUN mkdir -p /var/lib/mysql
COPY data/var/lib/mysql /var/lib/mysql
RUN chown -R 999:999 /var/lib/mysql

VOLUME /var/lib/mysql

# ECS環境では、containerが閉じられるとタスクが終了してしまうので
CMD tail -f /dev/null
