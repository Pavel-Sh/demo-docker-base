FROM amazoncorretto:17.0.3-alpine3.15
ONBUILD ARG JAR_FILE
ONBUILD COPY ${JAR_FILE} /app.jar
RUN adduser -D springboot
ENV MAX_HEAP 256m
EXPOSE ${PORT}
EXPOSE 8000
USER springboot
ENTRYPOINT exec java -Xmx${MAX_HEAP} \
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000 \
-Djava.security.egd=file:/dev/./urandom -jar /app.jar \
--spring.profiles.active=${PROFILE} --server.port=${PORT}