# Base stage
FROM node:20 AS base
WORKDIR /usr/src/app
COPY package*.json ./

# Development stage
FROM base AS development
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]

# Build stage
FROM base AS build
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine AS production
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

EXPOSE 3000
CMD ["node", "dist/main"]