# ---- Dev stage ----
FROM node:25-alpine AS dev

WORKDIR /app

# Copy dependency files first to leverage Docker layer caching
COPY api/package.json ./
COPY package-lock.json ./

# Install all dependencies (including devDependencies like tsx)
RUN npm install

CMD ["npm", "run", "dev"]

# ---- Build stage ----
FROM dev AS build

# Copy source code and config files
COPY api/ ./

# Generate Prisma client
RUN npx prisma generate

# Compile TypeScript
RUN npx tsc

# ---- Production stage ----
FROM node:25-alpine

WORKDIR /app

# Copy dependency files and install production-only dependencies
COPY api/package.json ./
COPY package-lock.json ./
RUN npm install --omit=dev

# Copy compiled output from build stage
COPY --from=build /app/dist ./dist

# Copy Prisma schema and generated client
COPY --from=build /app/prisma ./prisma
COPY --from=build /app/generated ./generated

EXPOSE 3000

CMD ["node", "dist/index.js"]
