#!/bin/bash
# Deploy PMWeb Agent to Google Cloud Run
# Same pattern as smart-gatekeeper
#
# Prerequisites:
#   - Google Cloud SDK installed and configured
#   - Docker installed locally
#   - gcloud auth configured
#
# Usage:
#   ./deploy.sh <PROJECT_ID> [REGION]
#   Example: ./deploy.sh my-gcp-project us-central1

set -e

# Configuration
PROJECT_ID="${1:-}"
SERVICE_NAME="pmweb-agent"
REGION="${2:-us-central1}"
IMAGE_NAME="pmweb-agent"

# Validate inputs
if [ -z "$PROJECT_ID" ]; then
    echo "Usage: ./deploy.sh <PROJECT_ID> [REGION]"
    echo "Example: ./deploy.sh my-gcp-project us-central1"
    echo ""
    echo "Required env vars:"
    echo "  OPENAI_API_KEY      - OpenAI API key"
    echo ""
    echo "Optional env vars:"
    echo "  PMWEB_BASE_URL      - PMWeb instance URL (default: cmcs.pmweb.com)"
    echo "  PMWEB_USERNAME      - PMWeb login (default: admin)"
    echo "  PMWEB_PASSWORD      - PMWeb password (default: pmweb2)"
    exit 1
fi

# Defaults
PMWEB_BASE_URL="${PMWEB_BASE_URL:-https://cmcs.pmweb.com/2025_1_00/pmweb/}"
PMWEB_USERNAME="${PMWEB_USERNAME:-admin}"
PMWEB_PASSWORD="${PMWEB_PASSWORD:-pmweb2}"

echo "=========================================="
echo "Deploying PMWeb Agent to Cloud Run"
echo "=========================================="
echo "Project ID: $PROJECT_ID"
echo "Service:    $SERVICE_NAME"
echo "Region:     $REGION"
echo "PMWeb URL:  $PMWEB_BASE_URL"
echo ""

# Step 1: Enable required APIs
echo "🔧 Enabling required GCP APIs..."
gcloud services enable run.googleapis.com containerregistry.googleapis.com --project $PROJECT_ID

# Step 2: Build Docker image
echo "🔨 Building Docker image..."
docker build -t gcr.io/$PROJECT_ID/$IMAGE_NAME:latest .

# Step 3: Push to Google Container Registry
echo "📤 Pushing image to GCR..."
docker push gcr.io/$PROJECT_ID/$IMAGE_NAME:latest

# Step 4: Deploy to Cloud Run
echo "🚀 Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
    --image gcr.io/$PROJECT_ID/$IMAGE_NAME:latest \
    --region $REGION \
    --platform managed \
    --allow-unauthenticated \
    --memory 2Gi \
    --timeout 3600 \
    --set-env-vars "OPENAI_API_KEY=$OPENAI_API_KEY,PMWEB_BASE_URL=$PMWEB_BASE_URL,PMWEB_USERNAME=$PMWEB_USERNAME,PMWEB_PASSWORD=$PMWEB_PASSWORD,PMWEB_HEADLESS=true" \
    --project $PROJECT_ID

echo ""
echo "=========================================="
echo "✅ Deployment Complete!"
echo "=========================================="
echo ""
echo "Get the service URL:"
echo "  gcloud run services describe $SERVICE_NAME --region $REGION --project $PROJECT_ID --format='value(status.url)'"
echo ""
echo "Test:"
echo "  curl https://<SERVICE_URL>/health"
echo ""
