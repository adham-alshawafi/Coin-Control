# Netlify Deployment Guide for COIN CONTROL

## 🚀 Quick Deployment Steps

### Method 1: Deploy from GitHub (Recommended)

1. **Push your code to GitHub** (if you haven't already)
2. **Go to [netlify.com](https://netlify.com)** and sign in
3. **Click "Add new site"** → **"Import an existing project"**
4. **Connect GitHub** and select your repository
5. **Configure build settings:**
   - Build command: `npm run build`
   - Publish directory: `dist`
   - Node version: `18`
6. **Click "Deploy site"**

### Method 2: Deploy using Netlify CLI

```bash
# Install Netlify CLI globally
npm install -g netlify-cli

# Login to Netlify
netlify login

# Deploy (preview)
npm run deploy:preview

# Deploy to production
npm run deploy:netlify
```

### Method 3: Use the deployment script

```bash
# Make script executable
chmod +x scripts/netlify-deploy.sh

# Deploy preview
./scripts/netlify-deploy.sh preview

# Deploy to production
./scripts/netlify-deploy.sh production
```

## ⚙️ Environment Variables Setup

After deployment, you need to configure environment variables in Netlify:

1. **Go to your site dashboard** in Netlify
2. **Navigate to:** Site settings → Environment variables
3. **Add these variables:**

```bash
# Required Supabase Configuration
VITE_SUPABASE_URL=https://qzkvzlakzrjagdnxbmlz.supabase.co
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key_here

# Application Configuration
VITE_APP_NAME=COIN CONTROL
VITE_APP_VERSION=1.0.0
VITE_APP_ENV=production

# Optional Configuration
VITE_API_TIMEOUT=30000
VITE_MAX_FILE_SIZE=5242880
VITE_ENABLE_ANALYTICS=true
```

## 🔧 Build Configuration

Your `netlify.toml` is already configured with:

- ✅ **Build command:** `npm run build`
- ✅ **Publish directory:** `dist`
- ✅ **Node version:** 18
- ✅ **Redirects:** SPA routing support
- ✅ **Security headers:** HTTPS, CSP, etc.
- ✅ **Caching:** Optimized for performance

## 🌐 Custom Domain Setup

After successful deployment:

1. **In Netlify dashboard:** Site settings → Domain management
2. **Add custom domain:** Enter your domain name
3. **Configure DNS:** Follow Netlify's instructions
4. **SSL certificate:** Automatically provisioned

## 📊 Monitoring & Analytics

### Built-in Netlify Features:
- **Analytics:** Site traffic and performance
- **Forms:** Contact form handling
- **Functions:** Serverless functions (if needed)
- **Split testing:** A/B testing capabilities

### Performance Optimization:
- ✅ **CDN:** Global content delivery
- ✅ **Compression:** Gzip/Brotli enabled
- ✅ **Caching:** Optimized cache headers
- ✅ **Image optimization:** Automatic WebP conversion

## 🔒 Security Features

Your deployment includes:

- **HTTPS enforcement**
- **Security headers** (CSP, HSTS, etc.)
- **Content type protection**
- **XSS protection**
- **Frame options** (clickjacking protection)

## 🚨 Troubleshooting

### Common Issues:

**Build fails:**
- Check Node version (should be 18)
- Verify all dependencies are in package.json
- Check for TypeScript errors

**Environment variables not working:**
- Ensure variables start with `VITE_`
- Check spelling and case sensitivity
- Redeploy after adding variables

**Routing issues:**
- Verify `netlify.toml` redirects are configured
- Check that `/*` redirects to `/index.html`

**Supabase connection fails:**
- Verify environment variables are set
- Check Supabase URL and key are correct
- Ensure CORS is configured in Supabase

## 📋 Deployment Checklist

Before deploying:
- [ ] Code is pushed to GitHub
- [ ] All tests pass locally
- [ ] Environment variables are ready
- [ ] Supabase is configured
- [ ] Build works locally (`npm run build`)

After deploying:
- [ ] Site loads correctly
- [ ] Authentication works
- [ ] Database connections work
- [ ] All pages are accessible
- [ ] Mobile responsiveness
- [ ] Performance is acceptable

## 🎯 Next Steps

1. **Test your deployment** thoroughly
2. **Set up custom domain** (optional)
3. **Configure monitoring** and analytics
4. **Set up continuous deployment** from GitHub
5. **Add team members** if needed

## 📞 Support Resources

- **Netlify Docs:** https://docs.netlify.com
- **Netlify Support:** https://www.netlify.com/support
- **Community Forum:** https://community.netlify.com
- **Status Page:** https://netlifystatus.com

---

Your COIN CONTROL app is now ready for production deployment! 🎉