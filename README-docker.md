# Salesforce DX + React Development with Docker

This project is configured to run in a Docker container, ensuring a consistent development environment for the whole team. It includes the Salesforce CLI (`sf`) and Node.js 22.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

1.  **Build and Start the container:**
    ```bash
    docker-compose up -d
    ```

2.  **Access the container's shell:**
    ```bash
    docker-compose exec app bash
    ```

3.  **Install dependencies:**
    Inside the container shell:
    ```bash
    # Install root dependencies (LWC/Aura tools)
    npm install

    # Install React UI Bundle dependencies
    cd force-app/main/default/uiBundles/EsquadraoMare
    npm install
    ```

## Salesforce Authentication

Since you are running inside a container, you must use the device login flow or the JWT flow.

**Device Login Flow:**
1.  Inside the container shell, run:
    ```bash
    sf org login device --alias my-org
    ```
2.  Copy the code and open the provided URL in your **host machine's browser**.
3.  Once authenticated, the container will have access to the org. Authentication state is persisted via Docker volumes.

## React Development

The React application uses Vite and is located in the UI Bundle directory.

1.  **Start the React dev server:**
    ```bash
    cd force-app/main/default/uiBundles/EsquadraoMare
    npm run dev
    ```
2.  The application will be available at [http://localhost:5173](http://localhost:5173).

## Useful Commands

| Action | Command (inside container) |
| :--- | :--- |
| Deploy metadata | `sf project deploy start` |
| Run LWC tests | `npm run test:unit` |
| Run React tests | `cd force-app/main/default/uiBundles/EsquadraoMare && npm run test` |
| Open Scratch Org | `sf org open` (Note: requires browser on host, might need `--url-only`) |

## Notes

- **Volumes:** The `.sf` and `.sfdx` directories are persisted in Docker volumes. Your authentication will survive container restarts.
- **Ports:** Port `5173` is exposed for the Vite dev server, and `5175` for Playwright E2E tests.
