# Cadence

A task management app built with Express, Prisma, and PostgreSQL — with a web frontend coming soon.

## Prerequisites

- [Node.js 25+](https://nodejs.org/) (see `.nvmrc`)
- [Docker](https://www.docker.com/) and Docker Compose

## Getting Started

```bash
# Clone the repository
git clone https://github.com/furkan-builds/cadence.git
cd cadence

# Install dependencies
npm install

# Start all services (PostgreSQL + API)
npm run start:docker
```

The API will be available at `http://localhost:3000` and Prisma Studio at `http://localhost:5555`.

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the full development plan.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow, scripts, and project structure.
