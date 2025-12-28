#!/bin/sh
set -e

echo "Starting Ollama..."
ollama serve &

# wait for server
sleep 5

echo "Pulling model..."
ollama pull qwen2.5:7b || true

echo "Starting OpenHands..."
python -m opendevin
