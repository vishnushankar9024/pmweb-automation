FROM python:3.11-slim

WORKDIR /app

# Install Chrome for Selenium + Node.js for frontend build
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc wget gnupg2 curl \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub \
       | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
       http://dl.google.com/linux/chrome/deb/ stable main" \
       > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Python deps
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir gunicorn

# Build frontend
COPY frontend/ ./frontend/
RUN cd frontend && npm install && npm run build

# Copy backend
COPY backend/app/ ./app/
COPY backend/pyproject.toml ./

# Move frontend build
RUN mv frontend/dist ./static

ENV PORT=8080
ENV PMWEB_HEADLESS=true
ENV PYTHONUNBUFFERED=1

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8080/health', timeout=5)"

CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 --worker-class uvicorn.workers.UvicornWorker app.main:app
