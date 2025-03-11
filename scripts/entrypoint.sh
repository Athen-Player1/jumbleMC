#!/bin/sh

# Check if the /data directory is empty and populate it if necessary
if [ -z "$(ls -A /data)" ]; then
  echo "Populating /data directory..."
  # Add commands to populate the /data directory here
  # For example, you can copy default data files from another location
  cp -r /tmp/mc/* /data/
fi
SERVER_PROPERTIES=/data/server.properties
# Execute the passed command
if [ -n "$MOTD" ]; then
    echo "motd=$MOTD" >> $SERVER_PROPERTIES
fi
if [ -n "$PORT" ]; then
    echo "server-port=$PORT" >> $SERVER_PROPERTIES
fi
if [ -n "$PLAYER_LIMIT" ]; then
    echo "max-players=$PLAYER_LIMIT" >> $SERVER_PROPERTIES
fi

if [ -n "$RESOURCE_PACK" ]; then
    echo "resource-pack=$RESOURCE_PACK" >> $SERVER_PROPERTIES
fi


if [ "$RCON" = "true" ]; then
    echo "enable-rcon=true" >> $SERVER_PROPERTIES
fi


if [ -n "$RCON_PORT" ]; then
    echo "rcon.port=$RCON_PORT" >> $SERVER_PROPERTIES
fi


if [ -n "$RCON_PASSWORD" ]; then
    echo "rcon.password=$RCON_PASSWORD" >> $SERVER_PROPERTIES
fi

if [ -n "$LEVEL_SEED" ]; then
    echo "level-seed=$LEVEL_SEED" >> $SERVER_PROPERTIES
fi

if [ -n "$SIM_DISTANCE" ]; then
    echo "sim-distance=$SIM_DISTANCE" >> $SERVER_PROPERTIES
fi

if [ -n "$VIEW_DISTANCE" ]; then
    echo "view-distance=$VIEW_DISTANCE" >> $SERVER_PROPERTIES
fi

if [ "$EULA" = "true" ]; then
    echo "eula=true" > eula.txt
fi

exec "$@"