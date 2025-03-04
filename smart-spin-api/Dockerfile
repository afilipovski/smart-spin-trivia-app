FROM maven:3.9.6 AS build

WORKDIR /app

COPY src ./src

COPY pom.xml .

RUN mvn clean package -DskipTests

FROM amazoncorretto:21-alpine3.16-jdk

WORKDIR /app

COPY --from=build /app .

CMD ["java", "-jar", "./target/smart-spin-api-0.0.1-SNAPSHOT.jar"]

EXPOSE 8080