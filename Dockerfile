FROM python:3.12-slim

# ---------- System deps ----------
RUN apt-get update && apt-get install -y \
    curl git libc6 libgcc-s1 libstdc++6 build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Ollama ----------
RUN curl -fsSL https://ollama.com/install.sh | sh

# ---------- App ----------
WORKDIR /app
COPY . .

RUN pip install --upgrade pip
RUN pip install -e .

# ---------- Ports ----------
EXPOSE 11434
EXPOSE 3000

# ---------- Start script ----------
CMD ollama serve & \
    sleep 5 && \
    ollama pull qwen2.5:1.5b && \
    python -m openhands
