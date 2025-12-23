FROM node:20-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy all remaining server files
COPY . .

# Tell Docker which port your server uses
EXPOSE 5000

# Start your server (you said you use node server.js)
CMD ["node", "server.js"]
