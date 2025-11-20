# Railway Deployment Guide

This guide will help you deploy your Strapi CMS to Railway.

## Prerequisites

1. A Railway account ([railway.app](https://railway.app))
2. GitHub repository with your code
3. All environment variables ready

## Step 1: Create a Railway Project

1. Go to [railway.app](https://railway.app) and sign in
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository
5. Railway will automatically detect the `cms/` directory

## Step 2: Add PostgreSQL Database

1. In your Railway project, click "New"
2. Select "Database" → "PostgreSQL"
3. Railway will automatically create and link the database
4. The `DATABASE_URL` environment variable will be automatically set

## Step 3: Set Environment Variables

Go to your service settings → Variables and add the following **required** environment variables:

### Required Environment Variables

1. **APP_KEYS** (Comma-separated array)
   - Generate 4 random keys: `openssl rand -base64 32` (run 4 times)
   - Format: `key1,key2,key3,key4`

2. **ADMIN_JWT_SECRET**
   - Generate: `openssl rand -base64 32`

3. **API_TOKEN_SALT**
   - Generate: `openssl rand -base64 32`

4. **TRANSFER_TOKEN_SALT**
   - Generate: `openssl rand -base64 32`

5. **ENCRYPTION_KEY**
   - Generate: `openssl rand -base64 32`

6. **NODE_ENV**
   - Set to: `production`

### Optional Environment Variables

- **HOST**: Set to `0.0.0.0` (default, Railway handles this)
- **PORT**: Railway automatically sets `$PORT`, but you can override
- **DATABASE_CLIENT**: Set to `postgres` (default)

**Note**: Railway automatically provides `DATABASE_URL` when you add a PostgreSQL service, so you don't need to set it manually.

## Step 4: Verify package.json

A `package.json` file has been created for you. Please verify that:
- All your dependencies are listed (especially if you have custom plugins)
- The scripts match your needs:
  - `start` script: `"start": "strapi start"` ✅
  - `build` script: `"build": "strapi build"` ✅

**Important**: If you have additional dependencies in your local `node_modules` that aren't in the created `package.json`, you'll need to add them before deployment. Railway will only install packages listed in `package.json`.

## Step 5: Deploy

1. Railway will automatically deploy when you push to your connected branch
2. Monitor the deployment in the Railway dashboard
3. Check logs if deployment fails

## Troubleshooting

### Build Fails
- Ensure `package.json` exists in the `cms/` directory
- Check that all dependencies are listed in `package.json`
- Review build logs in Railway dashboard

### Database Connection Issues
- Verify `DATABASE_URL` is set (Railway sets this automatically)
- Check that PostgreSQL service is running
- Ensure SSL is enabled (Railway PostgreSQL uses SSL by default)

### Application Crashes
- Check that all required environment variables are set
- Review application logs in Railway dashboard
- Verify `NODE_ENV=production`

### Port Issues
- Railway automatically sets the `PORT` environment variable
- Your server config should use `env.int('PORT', env.int('$PORT', 1337))`
- This is already configured in `dist/config/server.js`

## Post-Deployment

1. Access your Strapi admin panel at: `https://your-app.railway.app/admin`
2. Create your admin user
3. Start managing your content!

## Generating Secrets (Quick Command)

Run this command to generate all required secrets at once:

```bash
echo "APP_KEYS=$(openssl rand -base64 32),$(openssl rand -base64 32),$(openssl rand -base64 32),$(openssl rand -base64 32)"
echo "ADMIN_JWT_SECRET=$(openssl rand -base64 32)"
echo "API_TOKEN_SALT=$(openssl rand -base64 32)"
echo "TRANSFER_TOKEN_SALT=$(openssl rand -base64 32)"
echo "ENCRYPTION_KEY=$(openssl rand -base64 32)"
```

Copy each output line and add them as environment variables in Railway.

