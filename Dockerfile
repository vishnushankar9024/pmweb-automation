FROM python:3.11-slim

WORKDIR /app

# Install system dependencies including Chrome for Selenium
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    wget \
    gnupg2 \
    unzip \
    curl \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js for frontend build
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir gunicorn pymongo

# Build frontend
COPY frontend/ ./frontend/
RUN cd frontend && npm install && npm run build

# Copy backend code
COPY backend/app/ ./app/
COPY backend/pyproject.toml ./

# Move frontend build to static serving location
RUN mv frontend/dist ./static

# Environment variables
ENV PORT=8080
ENV PMWEB_BASE_URL=https://cmcs.pmweb.com/2025_1_00/pmweb/
ENV PMWEB_USERNAME=admin
ENV PMWEB_PASSWORD=pmweb2
ENV PMWEB_HEADLESS=true
ENV PYTHONUNBUFFERED=1

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8080/health', timeout=5)"

# Run with gunicorn
CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 --worker-class uvicorn.workers.UvicornWorker app.main:app
