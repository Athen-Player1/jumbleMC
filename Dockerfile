# Stage 1
FROM alpine:3.14 AS builder

# Install the necessary packages and download the server jar file
RUN apk add --no-cache wget unzip curl && \
	mkdir -p /opt/mcserver/ && \
	cd /opt/mcserver/ && \
	wget -O server.jar https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar

# Stage 2
FROM eclipse-temurin:21-jre-alpine-3.20 AS runner

ENV EULA false
ENV PORT 25565
ENV RESOURCE_PACK ""
ENV MOTD ""
ENV PLAYER_LIMIT 20
ENV RCON true
ENV RCON_PORT 25575
ENV RCON_PASSWORD "changeme"
ENV LEVEL-SEED ""
ENV SIM-DISTANCE 10
ENV VIEW-DISTANCE 10
ENV MAXMEMORY 1024M
ENV MINMEMORY 1024M

#create data directory
VOLUME /data/
WORKDIR /data/
RUN mkdir -p /tmp/mc
COPY --chown=755:755 --from=builder /opt/mcserver /tmp/mc
COPY --chown=755:755 --from=builder /opt/mcserver /tmp/mc
COPY --chown=755:755 /scripts /tmp/mc/scripts/

# Expose the port
EXPOSE $PORT

COPY --chown=755:755 /scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    apk update && \
    apk add --no-cache bash && \
    apk add --no-cache tmux


# Start the server
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash" , "/tmp/mc/scripts/startserver.sh"]