# Build stage 1.
# This state builds our TypeScript and produces an intermediate Docker image containing the compiled ReactScript code.
#
FROM node:14.20.0 AS appbuild

WORKDIR /app
COPY . .
RUN npm update
RUN npm install
RUN npm run build:development


#
# Build stage 2.
# This stage pulls the compiled JavaScript code from the stage 1 intermediate image.
# This stage builds the final Docker image.
#

FROM nginx:alpine

WORKDIR /usr/share/nginx/html
COPY --from=appbuild /app/build/. .
EXPOSE 80
CMD ["nginx","-g", "daemon off;"
