# Deployment Guide

This guide covers deploying Nexus Dashboard to Vercel (free tier).

## Prerequisites

- GitHub account
- Vercel account (free)
- Node.js 18+ installed locally

## Deployment Steps

### 1. Prepare Your Repository

Ensure your repository is ready for deployment:

```bash
# Navigate to project root
cd nexus-dashboard

# Install frontend dependencies
cd frontend
npm install

# Test local build
npm run build
```

### 2. Push to GitHub

```bash
# Initialize git if not already done
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit"

# Add remote (replace with your repo URL)
git remote add origin https://github.com/yourusername/nexus-dashboard.git

# Push to GitHub
git push -u origin main
```

### 3. Deploy to Vercel

#### Option A: Via Vercel Dashboard (Recommended)

1. Go to [vercel.com](https://vercel.com) and sign in
2. Click "Add New Project"
3. Import your GitHub repository
4. Configure the project:

**Project Settings:**
- **Framework Preset**: Vite
- **Root Directory**: `frontend`
- **Build Command**: `npm run build`
- **Output Directory**: `dist`
- **Install Command**: `npm install`

5. Click "Deploy"
6. Wait for deployment to complete
7. Your app will be available at `https://nexus-dashboard.vercel.app`

#### Option B: Via Vercel CLI

```bash
# Install Vercel CLI globally
npm install -g vercel

# Login to Vercel
vercel login

# Deploy from frontend directory
cd frontend
vercel

# Follow the prompts
# - Set root directory to . (current directory)
# - Confirm build settings
# - Deploy to production
vercel --prod
```

### 4. Environment Variables

For production, you may need to set environment variables:

In Vercel Dashboard:
1. Go to Project Settings
2. Click "Environment Variables"
3. Add the following:

```
VITE_API_BASE=https://your-backend-url.com
```

**Note**: Currently, the backend runs separately. For a complete deployment, you'll need to deploy the backend as well (see Backend Deployment section).

### 5. Custom Domain (Optional)

To use a custom domain on Vercel (free):

1. Go to Project Settings
2. Click "Domains"
3. Add your domain (e.g., `dashboard.yourdomain.com`)
4. Follow DNS instructions provided by Vercel

## Backend Deployment

The Dart backend can be deployed to various platforms. Here are options:

### Option 1: Railway (Free Tier)

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Initialize project
railway init

# Add backend
railway add backend

# Set port to 8080
railway variables set PORT=8080

# Deploy
railway up
```

### Option 2: Render (Free Tier)

1. Create a `Dockerfile` in the backend directory:

```dockerfile
FROM dart:3.0

WORKDIR /app
COPY pubspec.yaml .
RUN dart pub get

COPY . .
RUN dart pub get

EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
```

2. Push to GitHub
3. Connect to Render and deploy

### Option 3: Google Cloud Run (Free Tier Available)

```bash
# Build Docker image
docker build -t nexus-backend backend/

# Tag for Google Cloud
docker tag nexus-backend gcr.io/PROJECT_ID/nexus-backend

# Push to Google Container Registry
gcloud auth configure-docker
gcloud docker -- push gcr.io/PROJECT_ID/nexus-backend

# Deploy to Cloud Run
gcloud run deploy nexus-backend \
  --image gcr.io/PROJECT_ID/nexus-backend \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## Connecting Frontend to Backend

Once both are deployed:

1. Update `frontend/.env`:
```
VITE_API_BASE=https://your-backend-url.com
```

2. Rebuild and redeploy frontend:
```bash
cd frontend
npm run build
vercel --prod
```

## Troubleshooting

### Build Fails on Vercel

**Issue**: Build fails during deployment

**Solution**:
- Check build logs in Vercel dashboard
- Ensure all dependencies are in `package.json`
- Verify Node.js version compatibility

### CORS Errors

**Issue**: Frontend can't connect to backend

**Solution**:
- Ensure backend has CORS enabled
- Verify backend URL is correct in environment variables
- Check backend is running and accessible

### 404 Errors

**Issue**: Pages not found after deployment

**Solution**:
- Ensure `vite.config.js` has correct base path
- Check that `index.html` is in the root of frontend directory
- Verify build output directory is `dist`

### Authentication Issues

**Issue**: JWT token not working in production

**Solution**:
- Ensure JWT secret is consistent across environments
- Verify token expiration settings
- Check that HTTPS is being used in production

## Monitoring

### Vercel Analytics

Vercel provides built-in analytics:
- Page views
- Visitor demographics
- Performance metrics

Access via Vercel Dashboard → Analytics

### Backend Monitoring

For backend monitoring:
- Add logging to your Dart server
- Use platform-specific monitoring tools
- Set up uptime monitoring (e.g., UptimeRobot)

## Scaling

### Free Tier Limitations

**Vercel Free Tier**:
- 100GB bandwidth per month
- Unlimited deployments
- 100GB-Hours of serverless function execution
- Automatic SSL certificates

**Backend Free Tiers**:
- Railway: $5 free credit monthly
- Render: Free for web services with spin-up delay
- Cloud Run: Free tier with limits

### When to Upgrade

Consider upgrading when:
- You exceed free tier limits
- Need faster cold starts
- Require custom domains
- Need advanced analytics

## Security Best Practices

1. **Environment Variables**: Never commit secrets to git
2. **HTTPS**: Always use HTTPS in production
3. **CORS**: Restrict CORS to specific domains
4. **Rate Limiting**: Implement rate limiting on backend
5. **Input Validation**: Validate all inputs on server
6. **Dependencies**: Keep dependencies updated

## Backup Strategy

### Database Backup

When you add a database:
- Set up automated backups
- Export data regularly
- Store backups in multiple locations

### Code Backup

- Use GitHub for version control
- Tag releases
- Keep documentation updated

## Rollback Procedure

If deployment fails:

**Vercel**:
1. Go to Deployments in Vercel dashboard
2. Click on previous successful deployment
3. Click "Promote to Production"

**Backend**:
1. Revert to previous commit
2. Redeploy using your platform's CLI
3. Verify functionality

## Continuous Deployment

Set up automatic deployments on push:

**Vercel**:
- Automatically deploys on push to main branch
- Configure preview deployments for PRs

**Backend**:
- Connect GitHub repository to your platform
- Enable automatic deployments

## Support

For deployment issues:
- Check platform documentation
- Review build logs
- Search platform community forums
- Open an issue in this repository

## Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Railway Documentation](https://docs.railway.app)
- [Render Documentation](https://render.com/docs)
- [Dart Deployment Guide](https://dart.dev/guides/deploy)
- [Vite Deployment Guide](https://vitejs.dev/guide/build.html)
