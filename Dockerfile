# Step 1: Build the Angular app
FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Replace `your-app-name` with your actual Angular project name from angular.json
RUN npm run build -- --output-path=dist

# Step 2: Serve the app using NGINX
FROM nginx:alpine

# Copy the build output to NGINX's public folder
COPY --from=build /app/dist /usr/share/nginx/html

# Optional: custom NGINX config (only if needed)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
