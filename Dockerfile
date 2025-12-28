# ---------- BASE ----------
FROM python:3.12-slim

# ---------- SYSTEM DEPS ----------
RUN apt-get update && apt-get install -y \
  curl git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# ---------- INSTALL OLLAMA ----------
RUN curl -fsSL https://ollama.com/install.sh | sh

# ---------- SET WORKDIR ----------
WORKDIR /app

# ---------- COPY PROJECT ----------
COPY . .

# ---------- PYTHON SETUP ----------
RUN pip install --upgrade pip
RUN pip install -e .

# ---------- PORT ----------
EXPOSE 3000

# ---------- STARTUP ----------
CMD ollama serve & \
   sleep 5 && \
   ollama pull qwen2.5:7b && \
   python -m openhands
