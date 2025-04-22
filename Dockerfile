# Stage 1: Build the Angular app
FROM node:20 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build -- --output-path=docs --configuration production

# Stage 2: Serve the app using Nginx
FROM nginx:alpine

# Remove default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy build output to Nginx folder
COPY --from=build /app/docs /usr/share/nginx/html

# Optional: Copy custom nginx config (if needed)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

