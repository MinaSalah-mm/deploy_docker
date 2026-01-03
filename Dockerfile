
# to separate between the production and development environment two ways :


# 1. using argument variable being sent from the docker compose dev | prod

# FROM node:16-alpine

# workdir /app

# COPY package.json .

# ARG NODE_ENV
# RUN if [ "$NODE_ENV" = production ]; \
# 	then npm install --only=production; \
# 	else npm install; \
# 	fi

# # RUN npm install

# COPY ./src/ ./src/

# EXPOSE 4000

# CMD [ "npm", "run", "start-dev" ]

# -----------------------------------------------------------

# 2. using multi-staging one for prod & another for dev

FROM node:16-alpine AS base


FROM base AS production

workdir /app

COPY package.json .

RUN npm install --only=production

COPY ./src/ ./src/

EXPOSE 4000

CMD [ "npm", "start" ]



FROM base AS development

workdir /app

COPY package.json .

RUN npm install

COPY ./src/ ./src/

EXPOSE 4000

CMD [ "npm", "run", "start" ]
