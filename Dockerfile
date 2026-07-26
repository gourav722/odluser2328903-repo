# Use updated Alpine base image
FROM node:20-alpine3.22

WORKDIR /usr/src/app

# Upgrade Alpine security packages
RUN apk update && \
    apk upgrade libcrypto3 libssl3

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --omit=dev

# Copy application code
COPY . .

# Create non-root user
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /usr/src/app

USER appuser

EXPOSE 3000

CMD ["node", "app.js"]