# ---------- build frontend ----------
FROM node:20-slim AS frontend-build
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

# ---------- runtime ----------
FROM python:3.11-slim

# Chrome + Selenium dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget gnupg2 unzip curl fonts-liberation libnss3 libxss1 \
        libappindicator3-1 libasound2 libatk-bridge2.0-0 libgtk-3-0 \
        xdg-utils libgbm1 xvfb \
    && wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
       | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
       http://dl.google.com/linux/chrome/deb/ stable main" \
       > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ ./backend/
COPY --from=frontend-build /app/frontend/dist ./frontend/dist/
COPY start.sh ./start.sh
RUN chmod +x start.sh

ENV PYTHONUNBUFFERED=1
ENV PMWEB_HEADLESS=true

EXPOSE 8000

CMD ["./start.sh"]
