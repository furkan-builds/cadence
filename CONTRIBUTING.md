# Contributing

## Scripts

```bash
npm run start:docker    # Build and start all containers
npm run lint            # Check linting issues (Biome)
npm run lint:fix        # Auto-fix linting issues
npm run format          # Check formatting
npm run format:write    # Auto-fix formatting
```

### Prisma (run inside the container)

```bash
docker exec -it express-api npx prisma migrate dev    # Run migrations
docker exec -it express-api npx prisma generate        # Generate client
docker exec -it express-api npx prisma studio           # Open Prisma Studio
```

## Project Structure

```
cadence/
├── api/          # Express 5 + Prisma backend (TypeScript)
├── web/          # Frontend workspace (coming soon)
├── Dockerfile    # Multi-stage build for the API
└── docker-compose.yml
```

## Code Style

Biome handles both linting and formatting. Run `npm run lint:fix` and `npm run format:write` before committing.

## Working with Claude

This project uses [Claude Code](https://claude.ai/code) for development assistance. Project context is defined in `CLAUDE.md`.

```bash
# Start Claude Code in the project directory
claude

# Useful slash commands
/init           # Generate or update CLAUDE.md
/commit         # Stage and commit changes
```

See `CLAUDE.md` for architecture details, code style conventions, and commonly used commands.
