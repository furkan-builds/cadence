# Use the official Node.js image as a base
FROM node:25-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY api/package.json .
RUN npm install
