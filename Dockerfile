FROM ubuntu:22.04

# ---------- System packages ----------
RUN apt-get update && apt-get install -y \
    curl git python3 python3-pip python3-venv \
    nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Ollama ----------
RUN curl -fsSL https://ollama.com/install.sh | sh

ENV OLLAMA_HOST=0.0.0.0

# ---------- App setup ----------
WORKDIR /app
COPY . .

# Install Python deps for OpenHands the correct way
RUN pip install --upgrade pip
RUN pip install -e .

# ---------- Expose Ports ----------
EXPOSE 3000
EXPOSE 11434

# ---------- Startup Script ----------
CMD bash -c "\
  ollama serve & \
  sleep 5 && \
  ollama pull qwen2.5:7b && \
  python -m openhands \
"
