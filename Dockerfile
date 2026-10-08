FROM node:22-alpine AS build

WORKDIR /nodejs
COPY package*.json .
RUN npm ci --omit=dev 

FROM node:22-alpine

WORKDIR /nodeapp
COPY --from=build /nodejs/node_modules ./node_modules
COPY . .

RUN chown -R node:node /nodeapp
USER node

EXPOSE 3000
ENTRYPOINT ['npm']
CMD ['start']