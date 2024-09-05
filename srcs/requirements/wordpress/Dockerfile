FROM debian:bullseye

RUN apt update && apt install -y php7.4-fpm php7.4-mysqli curl

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/.
COPY tools/wp.sh .

RUN chmod +x wp.sh

CMD ["./wp.sh"]