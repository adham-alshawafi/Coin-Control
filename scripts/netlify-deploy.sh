#!/bin/bash

# Netlify Deployment Script for COIN CONTROL
# This script automates the deployment process to Netlify

set -e

echo "🚀 COIN CONTROL - Netlify Deployment Script"
echo "==========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️ $1${NC}"
}

# Check if Netlify CLI is installed
if ! command -v netlify &> /dev/null; then
    print_warning "Netlify CLI not found. Installing..."
    npm install -g netlify-cli
    print_status "Netlify CLI installed successfully"
fi

# Check if user is logged in to Netlify
if ! netlify status &> /dev/null; then
    print_info "Please log in to Netlify..."
    netlify login
fi

# Get deployment type
DEPLOY_TYPE=${1:-"preview"}

if [ "$DEPLOY_TYPE" != "production" ] && [ "$DEPLOY_TYPE" != "preview" ]; then
    print_error "Invalid deployment type. Use 'production' or 'preview'"
    echo "Usage: ./scripts/netlify-deploy.sh [production|preview]"
    exit 1
fi

print_info "Deployment type: $DEPLOY_TYPE"

# Install dependencies
print_info "Installing dependencies..."
npm ci
print_status "Dependencies installed"

# Run linting
print_info "Running linter..."
npm run lint
print_status "Linting passed"

# Build the application
print_info "Building application..."
if [ "$DEPLOY_TYPE" = "production" ]; then
    npm run build:production
else
    npm run build
fi
print_status "Build completed"

# Deploy to Netlify
print_info "Deploying to Netlify..."
if [ "$DEPLOY_TYPE" = "production" ]; then
    netlify deploy --prod --dir=dist
    print_status "Production deployment completed!"
else
    netlify deploy --dir=dist
    print_status "Preview deployment completed!"
fi

print_status "Deployment finished successfully! 🎉"
echo
print_info "Next steps:"
echo "1. Check your deployment URL"
echo "2. Test all functionality"
echo "3. Set up custom domain (if needed)"
echo "4. Configure environment variables"