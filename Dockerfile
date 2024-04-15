# Stage 1: Build the Spring Boot application
FROM maven:3.8.4-openjdk-17-slim as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper and project descriptor files
COPY mvnw .
COPY .mvn .mvn

# Copy the project files
COPY pom.xml .
COPY src src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create the Docker image
FROM openjdk:17-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged Spring Boot application JAR file from the previous stage
COPY --from=builder /app/target/numeric-0.0.1.jar /app/demo.jar

# Expose the port on which the Spring Boot application will run
EXPOSE 8080

ENTRYPOINT ["java","-jar","demo.jar"]
