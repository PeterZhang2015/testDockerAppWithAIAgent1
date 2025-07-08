# Multi-stage build for optimized Docker image

# Stage 1: Build stage
FROM node:24-alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Copy package files first for better caching
COPY package*.json ./

# Install all dependencies (including dev dependencies for potential build steps)
RUN npm ci --include=dev && npm cache clean --force

# Copy source code
COPY . .

# Optional: Run any build steps here if needed
# RUN npm run build

# Stage 2: Production runtime stage with Alpine Linux for minimal size
FROM node:24-alpine AS runtime

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Set working directory
WORKDIR /usr/src/app

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy package files
COPY package*.json ./

# Install only production dependencies and clean cache
RUN npm ci --only=production && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Copy application code from builder stage (only necessary files)
COPY --from=builder /usr/src/app/app.js ./
COPY --from=builder /usr/src/app/healthcheck.js ./

# Change ownership of app directory to nodejs user
RUN chown -R nodejs:nodejs /usr/src/app

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

# Start the application
CMD ["node", "app.js"]
