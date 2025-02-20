FROM mongo:4.4.6

WORKDIR /app

# Copy initialization script and JSON data into the container
# COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh
COPY users.json /app/users.json
COPY books.json /app/books.json

# Ensure the init script has execute permissions
# RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh