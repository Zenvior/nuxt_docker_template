FROM node:26-alpine AS builder

WORKDIR /app

COPY /src/package*.json ./

RUN npm install

COPY /src .

RUN npm run generate

FROM nginx

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
