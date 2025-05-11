# 1. Use Maven and JDK 17 to build everything
FROM maven:3.8.8-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2. Use JRE to run just the carservice
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/carservice/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
