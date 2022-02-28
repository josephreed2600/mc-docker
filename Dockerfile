FROM alpine:3.15.0 AS MCProvider
WORKDIR /app
RUN apk --no-cache update && apk --no-cache add wget
RUN wget https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar -O minecraft_server.jar

FROM debian
RUN apt update -y && apt upgrade -y && apt install -y openjdk-17-jre-headless
WORKDIR /app/storage
RUN echo eula=true > eula.txt
COPY --from=MCProvider /app/minecraft_server.jar /app/minecraft_server.jar
COPY ./server.properties .
CMD java -Xms1G -Xmx4G -jar /app/minecraft_server.jar nogui

EXPOSE 25565 25575
