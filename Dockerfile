# Use Maven to build the application
FROM maven:3.8.4-openjdk-21 AS build
WORKDIR /
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use the Amazon Corretto JDK base image
FROM amazoncorretto:21-alpine-jdk
WORKDIR /
COPY --from=build /target/AlumnoAPI-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
