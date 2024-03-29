FROM node:16.14.0-bullseye

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && \
    apt-get install -y coreutils binutils build-essential libseccomp-dev gcc apt-utils

COPY ./nosocket ./nosocket

RUN make -C ./nosocket/ all && make -C ./nosocket/ install

COPY ./packages ./packages

COPY ./scripts ./scripts

COPY package*.json .

# FIXME: this line below is to avoid npm's timeout.
# Uncomment this out if the development phase is finished.
COPY ./node_modules ./node_modules

RUN npm install

RUN node ./scripts/install.cjs

RUN node ./scripts/register-users.cjs

COPY tsconfig.json .

COPY ./src ./src

COPY build.js .

RUN npm run build

RUN rm -rf node_modules \
    && npm install --production

ENV PORT=50051

EXPOSE ${PORT}

CMD ["node", "./dist/index.js"]
