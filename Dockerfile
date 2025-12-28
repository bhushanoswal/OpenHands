FROM python:3.12-slim

# ---- System deps ----
RUN apt-get update && apt-get install -y \
    curl git build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---- Install Ollama ----
RUN curl -fsSL https://ollama.com/install.sh | sh

# ---- Create app dir ----
WORKDIR /app

# ---- Copy repo ----
COPY . .

# ---- Upgrade pip ----
RUN pip install --upgrade pip

# ---- Install OpenHands ----
RUN pip install -e .

# ---- Expose ports ----
EXPOSE 3000

# ---- Start Ollama + pull model + run server ----
CMD ollama serve & \
    sleep 5 && \
    ollama pull qwen2.5:7b && \
    python -m openhands
