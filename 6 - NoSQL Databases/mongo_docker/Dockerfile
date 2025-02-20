FROM mongo:4.4.6

# Copy initialization script and JSON data into the container
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh
COPY users.json /docker-entrypoint-initdb.d/users.json
COPY books.json /docker-entrypoint-initdb.d/books.json

# Ensure the init script has execute permissions
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh