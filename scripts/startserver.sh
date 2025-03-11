#!/bin/bash

tmux new-session -s minecraft java -Xmx${MAXMEMORY} -Xms${MINMEMORY} -jar /data/server.jar nogui