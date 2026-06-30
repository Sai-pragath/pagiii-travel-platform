# Pagiii Travel Platform

A modern, responsive travel destination and product management platform. 

## Features
- **Sleek UI/UX**: Completely redesigned frontend featuring glassmorphism, Unsplash imagery, and smooth hover animations.
- **Spring Boot Backend**: Robust Java backend utilizing Spring Boot, Spring Data JPA, and Thymeleaf.
- **MySQL Database**: Connected to a fully Dockerized MySQL 8.0 instance for reliable data storage.
- **CI/CD Ready**: Includes multiple automated Jenkins pipelines (Root, Database, and Docker Compose) for streamlined deployment.
- **Reverse Proxy**: Includes a highly secure Nginx reverse proxy architecture to route traffic cleanly on port 80.

## Running Locally / Deployment (Docker Compose)

The easiest and recommended way to deploy this application on any server (like AWS EC2) is using our pre-configured Docker Compose setup:

1. Clone this repository on your server.
2. Build and start the entire stack (Nginx, Spring Boot App, MySQL) in detached mode:
   ```bash
   docker compose up -d --build
   ```
3. Your application is now live on your server's public IP address (or `http://localhost` if running locally).

## Managing Components Individually

We've provided modular pipelines and scripts if you wish to run things individually:

- **Jenkins Pipelines**: We use simplified, pure-Bash Jenkinsfiles inside the repository for automation:
  - `Jenkinsfile` (Root): Builds the Spring Boot JAR, creates a Docker image, and deploys it on port 8083.
  - `database/Jenkinsfile`: Manages the MySQL Docker container lifecycle (start, stop, terminate).
  - `cicd/Jenkinsfile`: Handles `docker compose` automation for full-stack deployment.
