# Pagiii Travel Platform

A modern, responsive travel destination and product management platform. 

## Features
- **Sleek UI/UX**: Completely redesigned frontend featuring glassmorphism, Unsplash imagery, and smooth hover animations.
- **Spring Boot Backend**: Robust Java backend utilizing Spring Boot, Spring Data JPA, and Thymeleaf.
- **MySQL Database**: Connected to a fully Dockerized MySQL 8.0 instance for reliable data storage.
- **CI/CD Ready**: Includes multiple automated Jenkins pipelines (Root, Database, and Docker Compose) for streamlined deployment.
- **Reverse Proxy**: Includes a highly secure **native Apache** reverse proxy setup to strictly meet assessment requirements.

## Running Locally / Deployment (Docker Compose)

The easiest and recommended way to deploy this application on your AWS EC2 instance is using our pre-configured Docker Compose setup paired with our native Apache setup script:

1. Clone this repository on your server.
2. Build and start the Java and MySQL stack in detached mode:
   ```bash
   docker compose up -d --build
   ```
3. Install and configure the native Apache Reverse Proxy (Run this once!):
   ```bash
   ./setup-apache.sh
   ```
4. Verify the Apache service is running natively (as required by the assessment):
   ```bash
   systemctl status apache2
   ```

Your application is now live on your server's public IP address.

## Finishing the Assessment Rubric (Manual Steps)
To completely satisfy the assessment rubric, you must manually complete the DNS and SSL configurations:
1. **cPanel DNS**: Log into your provided cPanel account and add an **A Record** pointing your assigned domain to the EC2 Public IP.
2. **Let's Encrypt SSL**: Once the DNS resolves to your server, run the following to automatically secure Apache with HTTPS:
   ```bash
   sudo apt install certbot python3-certbot-apache
   sudo certbot --apache
   ```

## Managing Components Individually

We've provided modular pipelines and scripts if you wish to run things individually:

- **Jenkins Pipelines**: We use simplified, pure-Bash Jenkinsfiles inside the repository for automation:
  - `Jenkinsfile` (Root): Builds the Spring Boot JAR, creates a Docker image, and deploys it on port 8083.
  - `database/Jenkinsfile`: Manages the MySQL Docker container lifecycle (start, stop, terminate).
  - `cicd/Jenkinsfile`: Handles `docker compose` automation for full-stack deployment.
