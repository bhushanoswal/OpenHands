FROM ubuntu:22.04

# ---------- System deps ----------
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    nodejs \
    npm \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Ollama ----------
RUN curl -fsSL https://ollama.com/install.sh | sh

# ---------- Copy project ----------
WORKDIR /app
COPY . .

# ---------- Python deps ----------
# CHANGE THIS IF YOUR FILE IS DIFFERENT
RUN pip install --no-cache-dir -r backend/requirements.txt

# ---------- Expose Ports ----------
EXPOSE 3000
EXPOSE 11434

# ---------- Startup ----------
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
