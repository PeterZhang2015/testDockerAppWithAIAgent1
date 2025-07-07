# Test Docker App with AI Agent

A simple dockerized Node.js application created with AI agent assistance.

## Features

- Express.js web server
- RESTful API endpoints
- Health check endpoint
- Docker containerization
- Docker Compose configuration
- Production-ready security practices

## API Endpoints

- `GET /` - Welcome message with timestamp
- `GET /health` - Health check endpoint
- `GET /api/users` - Sample users API

## Quick Start

### Using Docker

1. Clone the repository:
   ```bash
   git clone https://github.com/PeterZhang2015/testDockerAppWithAIAgent1.git
   cd testDockerAppWithAIAgent1
   ```

2. Build and run with Docker:
   ```bash
   docker build -t test-docker-app .
   docker run -p 3000:3000 test-docker-app
   ```

3. Or use Docker Compose:
   ```bash
   docker-compose up --build
   ```

### Using Node.js directly

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the application:
   ```bash
   npm start
   ```

   For development with auto-restart:
   ```bash
   npm run dev
   ```

## Access the Application

Once running, visit:
- http://localhost:3000 - Main endpoint
- http://localhost:3000/health - Health check
- http://localhost:3000/api/users - Sample API

## Docker Commands

### Build the image
```bash
docker build -t test-docker-app .
```

### Run the container
```bash
docker run -p 3000:3000 test-docker-app
```

### Run in detached mode
```bash
docker run -d -p 3000:3000 --name my-app test-docker-app
```

### View logs
```bash
docker logs my-app
```

### Stop the container
```bash
docker stop my-app
```

### Remove the container
```bash
docker rm my-app
```

## Environment Variables

- `PORT` - Server port (default: 3000)
- `NODE_ENV` - Environment mode (development/production)

## Security Features

- Runs as non-root user
- Minimal Alpine Linux base image
- Health checks included
- Graceful shutdown handling
- Production dependencies only

## License

MIT
