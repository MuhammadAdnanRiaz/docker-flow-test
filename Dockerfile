# syntax=docker/dockerfile:1

FROM node:12.18.1 as base
ENV NODE_ENV=production

WORKDIR /code

COPY package.json package.json
COPY package-lock.json package-lock.json

FROM base as test
RUN npm ci
COPY . .
RUN npm install -g mocha
RUN npm run test


FROM base as prod
RUN npm install --production
COPY . .
CMD [ "node","server.js" ]