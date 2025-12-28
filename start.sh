#!/bin/bash
set -e

echo "Starting Ollama..."
ollama serve &

# wait for ollama to boot
sleep 5

echo "Pulling model (first time only)..."
ollama pull qwen2.5:7b || true

echo "Starting OpenDevin..."
python app.py
