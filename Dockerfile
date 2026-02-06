
FROM node:19-alpine AS builder
RUN apk add --no-cache bash curl
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 3001
ENTRYPOINT [ "./start.sh" ]