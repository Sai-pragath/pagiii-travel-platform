# Pagiii Travel Platform

A modern, responsive travel destination and product management platform. 

## Features
- **Sleek UI/UX**: Completely redesigned frontend using Tailwind CSS, featuring glassmorphism, Unsplash imagery, and smooth hover animations.
- **Spring Boot Backend**: Robust Java backend utilizing Spring Boot, Spring Data JPA, and Thymeleaf.
- **MySQL Database**: Pre-configured to connect to a MySQL database for reliable data storage.
- **CI/CD Ready**: Includes a simple `Jenkinsfile` for automated builds and deployment.

## Running Locally

1. Ensure MySQL is running on port `3306` with username `root` and password `1234` (or update `application.properties` with your credentials).
2. Start the application using Maven:
   ```bash
   ./mvnw spring-boot:run
   ```
3. Visit `http://localhost:8081` in your browser.

## Deployment to AWS
This application is configured for deployment on AWS. To connect to an RDS instance or an external database, update the `spring.datasource.url` in `application.properties` with your AWS DB endpoint.
