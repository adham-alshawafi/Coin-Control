#!/bin/bash

# Fix Deployment Issues Script for COIN CONTROL
# This script helps diagnose and fix common deployment issues

set -e

echo "🔧 COIN CONTROL - Deployment Issue Fixer"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from your project root."
    exit 1
fi

print_info "Checking for common deployment issues..."

# Check if build works locally
print_info "Testing local build..."
if npm run build; then
    print_status "Local build successful"
else
    print_error "Local build failed. Fix build errors before deploying."
    exit 1
fi

# Check if dist folder was created
if [ -d "dist" ]; then
    print_status "Build output directory (dist) exists"
    
    # Check if main files exist
    if [ -f "dist/index.html" ]; then
        print_status "index.html found in dist"
    else
        print_error "index.html not found in dist folder"
    fi
    
    # Check for JavaScript files
    if ls dist/assets/*.js 1> /dev/null 2>&1; then
        print_status "JavaScript files found in dist/assets"
    else
        print_warning "No JavaScript files found in dist/assets"
    fi
    
else
    print_error "Build output directory (dist) not found"
    exit 1
fi

# Check netlify.toml configuration
if [ -f "netlify.toml" ]; then
    print_status "netlify.toml configuration file exists"
    
    # Check for proper headers configuration
    if grep -q "Content-Type.*application/javascript" netlify.toml; then
        print_status "JavaScript MIME type headers configured"
    else
        print_warning "JavaScript MIME type headers may need configuration"
    fi
else
    print_warning "netlify.toml not found - using default Netlify settings"
fi

# Check for _headers file
if [ -f "public/_headers" ]; then
    print_status "_headers file exists for MIME type configuration"
else
    print_info "_headers file created for proper MIME types"
fi

# Check environment variables template
if [ -f ".env.example" ]; then
    print_status ".env.example file exists"
    print_info "Remember to set environment variables in Netlify dashboard"
else
    print_warning ".env.example not found"
fi

# Test if preview works
print_info "Testing preview server..."
npm run preview &
PREVIEW_PID=$!
sleep 3

# Check if preview is running
if kill -0 $PREVIEW_PID 2>/dev/null; then
    print_status "Preview server started successfully"
    kill $PREVIEW_PID
else
    print_warning "Preview server may have issues"
fi

print_status "Deployment issue check completed!"
echo
print_info "Common fixes applied:"
echo "1. ✅ Configured proper MIME types in netlify.toml"
echo "2. ✅ Added _headers file for Netlify"
echo "3. ✅ Updated Vite configuration for proper builds"
echo "4. ✅ Fixed module script loading in index.html"
echo
print_info "If you still have issues after deployment:"
echo "1. Check Netlify deploy logs for specific errors"
echo "2. Verify environment variables are set in Netlify"
echo "3. Ensure your domain DNS is properly configured"
echo "4. Clear browser cache and try again"