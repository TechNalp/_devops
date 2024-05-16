FROM node:18-slim

RUN mkdir /usr/local/app
WORKDIR /usr/local/app

COPY . .

RUN npm install -g nodemon; npm ci; npm cache clean --force; mv /usr/local/app/node_modules /node_modules

ENV PORT 4000
EXPOSE 4000
ENV NPM_CONFIG_LOGLEVEL debug

ENTRYPOINT [ "node" ]
CMD ["server.js"]