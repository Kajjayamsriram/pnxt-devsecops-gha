FROM node:25-alpine AS build

WORKDIR /nodejs
COPY package*.json ./   
RUN --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

FROM node:25-alpine

WORKDIR /nodeapp
COPY --from=build --chown=node:node /nodejs/node_modules ./node_modules
COPY --chown=node:node . .

# RUN chown -R node:node /nodeapp #To increase speed rather modifying perm
USER node
EXPOSE 3000
CMD ["npm", "start"]