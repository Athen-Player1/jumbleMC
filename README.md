# Jumble Minecraft Server Docker

This repository contains a Docker setup for running a Minecraft server using Alpine Linux and Eclipse Temurin JRE 21.

## Features
- Lightweight Alpine-based image
- Automatic download of the latest Minecraft server jar
- Configurable environment variables for server settings
- Persistent data storage via Docker volumes

## Environment Variables
| Variable        | Default Value | Description |
|----------------|--------------|-------------|
| `EULA`         | `false`       | Must be set to `true` to accept Mojang's EULA |
| `PORT`         | `25565`       | Server port |
| `RESOURCE_PACK` | `""`         | URL to a resource pack |
| `MOTD`         | `""`         | Message of the day |
| `PLAYER_LIMIT` | `20`         | Maximum number of players |
| `LEVEL-SEED`   | `""`         | Custom level seed |
| `SIM-DISTANCE` | `10`         | Simulation distance |
| `VIEW-DISTANCE` | `10`        | View distance |
| `MAXMEMORY`    | `1024M`      | Maximum allocated memory |
| `MINMEMORY`    | `1024M`      | Minimum allocated memory |

## Docker Compose Example

To run the server using Docker Compose, create a `docker-compose.yml` file with the following content:

```yaml
version: '3.8'
services:
  minecraft:
    image: ghcr.io/athen-player1/jumblemc:main
    container_name: minecraft-server
    ports:
      - "25565:25565"
      - "25575:25575" # RCON Port
    environment:
      EULA: "true"
      PORT: 25565
      PLAYER_LIMIT: 20
      MAXMEMORY: "2048M"
      MINMEMORY: "1024M"
    volumes:
      - ./data:/data
    restart: unless-stopped
```

## Running the Server

1. Build the Docker image:
   ```sh
   docker build -t my-minecraft-server .
   ```
2. Run the container:
   ```sh
   docker run -d --name minecraft-server -p 25565:25565 -p 25575:25575 \
      -e EULA=true -e RCON_PASSWORD=supersecret \
      -v $(pwd)/data:/data \
      my-minecraft-server
   ```
3. Use Docker Compose:
   ```sh
   docker-compose up -d
   ```

## Connecting to the server
Once the container is running the server will auto start in a Tmux session. It can be accessed by using

``` tmux attach ```

## Notes
- Ensure you set `EULA=true` to comply with Mojang's licensing.
- Change the RCON password for security.
- Data is stored in a volume (`/data`) to persist across restarts.

## License
This project is released under an open-source license. Modify and distribute as needed.
