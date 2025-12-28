FROM python:3.11-slim

# ---------- System dependencies ----------
RUN apt update && apt install -y \
    curl git nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# ---------- Install Ollama ----------
RUN curl -fsSL https://ollama.com/install.sh | sh

# ---------- Setup working dir ----------
WORKDIR /app
COPY . .

# ---------- Python deps ----------
RUN pip install -r requirements.txt

# ---------- Expose Ports ----------
EXPOSE 3000
EXPOSE 11434

# ---------- Startup ----------
RUN chmod +x start.sh
CMD ["./start.sh"]
