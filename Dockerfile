FROM node:14 as build-stage

WORKDIR /app

COPY package*.json angular.json tsconfig.json index.html .

RUN npm install

COPY ./src ./src

RUN npm run build


FROM node:14 as serve-stage

WORKDIR /app

RUN npm install -g serve

COPY --from=build-stage /app/dist .

CMD serve -s -p 8080 /app
