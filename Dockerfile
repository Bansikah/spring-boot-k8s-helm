# Dockerfile
FROM eclipse-temurin:21-jdk AS build-stage

WORKDIR /app

COPY . .

RUN ./mvnw clean package

FROM eclipse-temurin:21-jre-alpine

# Copy the JAR file from the build stage
COPY --from=build-stage /app/target/docker-init-demo-0.0.1-SNAPSHOT.jar .

COPY ./run.sh .
RUN chmod +x run.sh

EXPOSE 9292

CMD ["sh", "run.sh"]
