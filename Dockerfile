FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk
WORKDIR /app

RUN groupadd spring && useradd -g spring spring
RUN mkdir -p /data && chown spring:spring /data

USER spring:spring

ENV SERVER_PORT=8000
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

COPY --from=builder /app/target/demo-0.0.1.jar app.jar

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl --fail http://localhost:${SERVER_PORT}/actuator/health || exit 1

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]