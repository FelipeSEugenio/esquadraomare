# Use Node.js 22 as the base image
FROM node:22-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    openjdk-11-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

# Install Salesforce CLI
RUN npm install -g @salesforce/cli

# Set the working directory
WORKDIR /workspace

# Set environment variables for Salesforce CLI
ENV SF_CONTAINER_MODE=true
ENV SF_AUTO_UPDATE_CHECK=false

# Expose Vite dev server port
EXPOSE 5173
# Expose Playwright E2E port
EXPOSE 5175

# Default command: show versions and keep container running
CMD ["bash", "-c", "sf --version && node -v && npm -v && tail -f /dev/null"]
