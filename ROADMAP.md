# Roadmap

## Phase 1 — Foundation & Developer Experience

Get the API into a solid, maintainable state before building features.

- [x] **Migrate API to TypeScript** — `index.js` is plain JS despite having `tsconfig.base.json`. Create a `tsconfig.json` in `api/` that extends the base config, rename to `.ts`, and set up a build step.
- [x] **Add a `.dockerignore`** — exclude `node_modules`, `dist`, `.git`, `.env` files to speed up Docker builds and reduce image size.
- [x] **Improve Dockerfile** — use multi-stage builds (build stage for TypeScript compilation, production stage for running). Copy `package.json` and `package-lock.json` first to leverage Docker layer caching.
- [x] **Add `nodemon` or `tsx watch`** — the container currently runs `node index.js` with no hot reload. Add a dev command that watches for file changes.
- [x] **Create a proper `docker-compose.override.yml`** — separate dev-specific config (volume mounts, watch mode) from production config.
- [x] **Clean up `api/package.json`** — it has ~130+ direct dependencies, many of which are transitive (e.g. `call-bind-apply-helpers`, `side-channel-weakmap`). Trim to only what you actually import, let npm handle the rest.
- [x] **Add `npm run dev` and `npm run build` scripts** — both in root and in `api/` workspace.
- [ ] **Set up path aliases** — configure `tsconfig.json` paths for cleaner imports (e.g. `@/routes`, `@/services`).

## Phase 2 — API Structure & Database

Build a real API structure with proper Prisma models.

- [ ] **Design your database schema** — add models to `prisma/schema.prisma`. Decide on your domain entities and relationships.
- [ ] **Run initial migration** — `npx prisma migrate dev --name init` to create the database tables.
- [ ] **Set up a project structure** — organize the API into layers:
  ```
  api/
  ├── src/
  │   ├── routes/        # Express route handlers
  │   ├── services/      # Business logic
  │   ├── middleware/     # Auth, error handling, validation
  │   ├── lib/           # Shared utilities (prisma client, etc.)
  │   └── index.ts       # App entry point
  ├── prisma/
  │   └── schema.prisma
  └── tsconfig.json
  ```
- [ ] **Create a Prisma client singleton** — instantiate and export `PrismaClient` from a shared module so it's reused across the app.
- [ ] **Add request validation** — use `valibot` (already installed) to validate request bodies and params in routes.
- [ ] **Add error handling middleware** — centralized Express error handler that catches errors and returns consistent JSON responses.
- [ ] **Add a health check endpoint** — `GET /health` that checks database connectivity.

## Phase 3 — Authentication & Security

- [ ] **Add authentication** — implement JWT-based auth or session-based auth. Add login/register endpoints.
- [ ] **Add auth middleware** — protect routes that require authentication.
- [ ] **Add rate limiting** — use `express-rate-limit` to prevent abuse.
- [ ] **Add CORS configuration** — configure `cors` middleware with proper allowed origins for the web frontend.
- [ ] **Add helmet** — security headers middleware.
- [ ] **Use environment-specific configs** — separate `.env.development`, `.env.production`, `.env.test`.

## Phase 4 — Testing

- [ ] **Set up a test framework** — add `vitest` (works well with TypeScript, fast, no config needed).
- [ ] **Add unit tests for services** — test business logic in isolation.
- [ ] **Add integration tests for routes** — use `supertest` to test API endpoints against a test database.
- [ ] **Add a test database** — separate PostgreSQL database (or use Docker test container) for running tests without affecting dev data.
- [ ] **Add test scripts** — `npm test`, `npm run test:watch`, `npm run test:coverage`.

## Phase 5 — Web Frontend

- [ ] **Choose a framework** — set up the `web/` workspace with React (already a dependency), Next.js, or Vite + React.
- [ ] **Create a `tsconfig.json`** in `web/` extending the base config.
- [ ] **Set up API client** — typed HTTP client that talks to the Express API.
- [ ] **Add the web service to `docker-compose.yml`** — or run it locally with a proxy to the API container.
- [ ] **Build core pages** — based on your domain (auth pages, dashboard, etc.).

## Phase 6 — CI/CD & Deployment

- [ ] **Add GitHub Actions** — lint, type-check, and test on every PR.
- [ ] **Add pre-commit hooks** — use `husky` + `lint-staged` to run Biome checks before commits.
- [ ] **Add a production Dockerfile** — optimized multi-stage build without dev dependencies.
- [ ] **Set up deployment** — choose a hosting provider and add deploy pipeline (e.g. Railway, Fly.io, AWS).
- [ ] **Add database migration step to CI** — run `prisma migrate deploy` in production pipeline.

## Quick Wins (do anytime)

- [x] **Add a `.nvmrc`** — pin the Node.js version (e.g. `25`) so all contributors use the same version.
- [x] **Add a proper `README.md`** at the root — describe what Cadence is, how to set up locally, and link to this roadmap.
- [ ] **Remove `web/temp.ts`** — replace with actual project scaffolding when ready.
- [x] **Add `engines` field to root `package.json`** — enforce minimum Node.js version.
