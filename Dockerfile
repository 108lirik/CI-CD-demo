FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/demo
COPY app.jar /opt/demo/
WORKDIR /opt/demo/

CMD ["java", "-jar", "/opt/demo/app.jar"]
