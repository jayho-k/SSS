FROM node:12.18
WORKDIR .

COPY package.json .

ADD . .
RUN npm install

CMD ["npm", "run", "serve"]
