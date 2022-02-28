FROM alpine:3.15.0 AS MCProvider
WORKDIR /app
RUN apk --no-cache update && apk --no-cache add wget
RUN wget https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar -O minecraft_server.jar

FROM debian
WORKDIR /app/storage

RUN apt update -y && apt upgrade -y && apt install -y openjdk-17-jre-headless tmux

COPY --from=MCProvider /app/minecraft_server.jar /app/minecraft_server.jar

CMD echo eula=true > eula.txt && tmux new java -Xms1G -Xmx4G -jar /app/minecraft_server.jar nogui 

