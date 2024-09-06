FROM debian:bullseye

# Update and install MariaDB server
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Copy configuration and scripts into the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/mariadb.sh .

# Set proper ownership for MariaDB data directory
RUN chown -R mysql:mysql /var/lib/mysql


# Make sure the script is executable
RUN mkdir /run/mysqld && chmod +x mariadb.sh

# Set the entrypoint to the script
CMD ["./mariadb.sh"]