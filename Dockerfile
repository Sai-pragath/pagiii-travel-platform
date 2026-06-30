# Stage 1: Build the application using Maven
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

# Copy maven executable to the image
COPY mvnw .
COPY .mvn .mvn

# Copy the pom.xml file
COPY pom.xml .

# Make the wrapper executable
RUN chmod +x ./mvnw

# Download all required dependencies into one layer
RUN ./mvnw dependency:go-offline -B

# Copy your other files
COPY src src

# Build the project
RUN ./mvnw clean package -DskipTests

# Stage 2: Create the final lightweight image
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/spring_app_pagiii-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
