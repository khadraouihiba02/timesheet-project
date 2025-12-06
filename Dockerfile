FROM eclipse-temurin:11-jdk
LABEL maintainer="Hiba Khadraoui - 4TWIN4"

WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "app.jar"]

