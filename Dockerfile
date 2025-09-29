# --------  Build Stage --------
FROM node:18 AS builder

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy source files
COPY . .

# -------- Production Image --------
FROM node:18-slim

WORKDIR /app

# Copy only the built app and node_modules from builder
COPY --from=builder /app /app

# Expose application port
EXPOSE 3000

# Run the app
CMD ["npm", "start"]
