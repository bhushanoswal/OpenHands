FROM ubuntu:22.04

# Basic packages
RUN apt-get update && apt-get install -y \
    curl ca-certificates git python3 python3-pip nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Ollama ----------
RUN curl -fsSL https://ollama.com/install.sh | sh

# Pull a FREE model (good + light)
RUN ollama pull qwen2.5:7b

# ---------- OpenDevin ----------
WORKDIR /app
COPY . .

RUN pip3 install -r requirements.txt || pip3 install -r requirements-dev.txt

# 3000 = OpenDevin
# 11434 = Ollama
EXPOSE 3000
EXPOSE 11434

ENV LLM_PROVIDER=ollama
ENV OLLAMA_MODEL=qwen2.5:7b
ENV OLLAMA_BASE_URL=http://localhost:11434
ENV MAX_ITERATIONS=15
ENV WORKSPACE_BASE=/workspace

CMD ollama serve & python3 app.py
