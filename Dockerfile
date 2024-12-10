FROM openjdk:17-jdk-slim

WORKDIR /app

COPY pom.xml .
COPY src /app/src

RUN apt-get update && apt-get install -y maven
RUN mvn dependency:go-offline
RUN mvn clean test  # Run tests during Docker build

RUN mvn clean package -DskipTests  # Skip tests after they run

# Copy the built JAR file (use the correct name of the JAR file)
COPY target/my-app-1.0-SNAPSHOT.jar app.jar

# Expose the application's port
EXPOSE 8086

# Run the JAR file
CMD ["java", "-jar", "app.jar"]

