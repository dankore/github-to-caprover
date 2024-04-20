FROM node:20-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN npm install -g caprover

COPY run.sh /app/run.sh

RUN chmod +x /app/run.sh

ENTRYPOINT ["sh", "/app/run.sh"]
