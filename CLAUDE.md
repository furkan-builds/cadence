# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Cadence is a monorepo with two workspaces: `api` (Express + Prisma backend) and `web` (frontend, currently scaffolding only). The project runs via Docker containers (PostgreSQL + Express API).

## Commands

### Docker (primary way to run)
```bash
npm run start:docker          # Build and start all containers (postgres + api)
docker compose up --build -d  # Equivalent direct command
```

### Linting & Formatting (Biome)
```bash
npm run lint          # Check linting issues
npm run lint:fix      # Auto-fix linting issues
npm run format        # Check formatting
npm run format:write  # Auto-fix formatting
```

### Prisma (run inside the express-api container)
```bash
docker exec -it express-api npx prisma migrate dev    # Run migrations
docker exec -it express-api npx prisma generate        # Generate client
docker exec -it express-api npx prisma studio           # Open Prisma Studio (port 5555)
```

## Architecture

- **Monorepo** using npm workspaces (`api/`, `web/`). Root `package.json` manages shared tooling (Biome, dotenv).
- **API** (`api/`): Express 5 app running in Docker (Node 25 Alpine). Uses Prisma ORM with PostgreSQL. Prisma client output goes to `api/generated/prisma/`. Config is in `api/prisma.config.ts` and schema in `api/prisma/schema.prisma`.
- **Web** (`web/`): Frontend workspace, currently a placeholder.
- **Docker**: `docker-compose.yml` defines two services: `postgres-database` (port 5432) and `express-api` (port 3000, Prisma Studio on 5555). The API source is volume-mounted from `./api` into the container at `/app`.
- **Environment**: `.env` at root provides `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DATABASE`. The `DATABASE_URL` is constructed in docker-compose.yml.

## Code Style

- Biome handles both linting and formatting (no ESLint/Prettier)
- Double quotes, semicolons, trailing commas, arrow function parentheses always
- Line width: 120, indent: 2 spaces
- TypeScript target: ES2022, module: NodeNext, strict mode enabled
