FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y \
    cowsay \
    fortune-mod \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x wisecow.sh

EXPOSE 4499
CMD ["./wisecow.sh"]
