FROM python:3.12-slim

WORKDIR /app

# System deps
RUN apt-get update && apt-get install -y \
  curl git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# ---- Install Ollama binary ----
RUN curl -fsSL https://ollama.com/install.sh | sh

# ---- Copy project ----
COPY . .

# ---- Fix README.md missing ----
RUN test -f README.md || echo "OpenHands" > README.md

# ---- Python deps ----
RUN pip install --upgrade pip
RUN pip install -e .

# ---- Expose API port ----
EXPOSE 3000

# ---- Start both Ollama + OpenHands ----
CMD ollama serve & sleep 3 && \
    ollama pull qwen2.5:7b && \
    openhands server --host 0.0.0.0 --port 3000
