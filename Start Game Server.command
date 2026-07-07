#!/bin/bash
cd "$(dirname "$0")"
echo "Starting local server for Animal Simulator 3D..."
echo "Opening the game in your browser..."
( sleep 1 && open "http://localhost:8000/dragon-cat-bird-simulator.html" ) &
python3 -m http.server 8000
