# Simple Node/Express static server placeholder (adjust per repo)
FROM node:18-alpine
WORKDIR /app
COPY . .
RUN npm ci --production || true
EXPOSE 80
CMD [ "node", "server.js" ]
