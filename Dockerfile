
# Stage 1: Build the Spring Boot application
FROM maven:3-jdk-8-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY pom.xml .
COPY src src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create the Docker image
FROM quay.io/anshuk6469/openjdk8

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged Spring Boot application JAR file from the previous stage
COPY --from=builder /app/target/numeric-0.0.1.jar /app/demo.jar

# Expose the port on which the Spring Boot application will run
EXPOSE 8080

ENTRYPOINT ["java","-jar","demo.jar"]
