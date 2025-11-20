# How to Set Environment Variables in Railway

Yes, you need to set **6 required environment variables** in Railway. Railway will automatically set `DATABASE_URL` and `PORT` for you.

## Required Environment Variables

You need to set these **6 variables**:

1. `APP_KEYS` - 4 comma-separated random keys
2. `ADMIN_JWT_SECRET` - Random secret string
3. `API_TOKEN_SALT` - Random salt string
4. `TRANSFER_TOKEN_SALT` - Random salt string
5. `ENCRYPTION_KEY` - Random encryption key
6. `NODE_ENV` - Set to `production`

**Railway automatically provides:**
- `DATABASE_URL` - When you add PostgreSQL service ✅
- `PORT` - Automatically set ✅

---

## Step-by-Step: Setting Variables in Railway

### Method 1: Using Railway Dashboard (Recommended)

1. **Go to your Railway project**
   - Log in to [railway.app](https://railway.app)
   - Select your project

2. **Select your service** (the one running your Strapi app)

3. **Click on the "Variables" tab**
   - You'll see this in the top menu of your service
   - Or click the service settings → "Variables" tab

4. **Click "New Variable" or "+" button**

5. **Add each variable one by one:**
   
   For each variable:
   - **Variable Name**: Enter the name (e.g., `APP_KEYS`)
   - **Value**: Enter the generated value
   - Click "Add" or "Save"

6. **Repeat for all 6 variables**

### Method 2: Using Railway CLI (Alternative)

If you have Railway CLI installed:

```bash
railway variables set APP_KEYS="key1,key2,key3,key4"
railway variables set ADMIN_JWT_SECRET="your-secret"
railway variables set API_TOKEN_SALT="your-salt"
railway variables set TRANSFER_TOKEN_SALT="your-transfer-salt"
railway variables set ENCRYPTION_KEY="your-encryption-key"
railway variables set NODE_ENV="production"
```

---

## Quick Secret Generation

### Option 1: Generate All Secrets at Once (Windows PowerShell)

Run this in PowerShell to generate all secrets:

```powershell
Write-Host "APP_KEYS=$((1..4 | ForEach-Object { [Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 })) }) -join ',')"
Write-Host "ADMIN_JWT_SECRET=$([Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 })))"
Write-Host "API_TOKEN_SALT=$([Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 })))"
Write-Host "TRANSFER_TOKEN_SALT=$([Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 })))"
Write-Host "ENCRYPTION_KEY=$([Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 })))"
Write-Host "NODE_ENV=production"
```

### Option 2: Generate One by One (Git Bash or WSL)

If you have Git Bash or WSL (Windows Subsystem for Linux):

```bash
# Generate APP_KEYS (4 keys)
echo "APP_KEYS=$(openssl rand -base64 32),$(openssl rand -base64 32),$(openssl rand -base64 32),$(openssl rand -base64 32)"

# Generate other secrets
echo "ADMIN_JWT_SECRET=$(openssl rand -base64 32)"
echo "API_TOKEN_SALT=$(openssl rand -base64 32)"
echo "TRANSFER_TOKEN_SALT=$(openssl rand -base64 32)"
echo "ENCRYPTION_KEY=$(openssl rand -base64 32)"
echo "NODE_ENV=production"
```

### Option 3: Use Online Generator

You can also use an online base64 generator:
- Go to https://www.random.org/strings/
- Generate random strings (32+ characters)
- Convert to base64 if needed

---

## Example Values (For Reference Only - Generate Your Own!)

Here's what the format looks like (but **generate your own unique values**):

```
APP_KEYS=Y3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2QsY3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2QsY3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2QsY3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2Q=

ADMIN_JWT_SECRET=Y3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2R1Y3Rpb24=

API_TOKEN_SALT=Y3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2R1Y3Rpb24=

TRANSFER_TOKEN_SALT=Y3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2R1Y3Rpb24=

ENCRYPTION_KEY=Y3JhdGVkIGJ5IG1oazQxLCBkZWZhdWx0IGtleSwgY2hhbmdlIGluIHByb2R1Y3Rpb24=

NODE_ENV=production
```

---

## Visual Guide: Railway Dashboard

1. **After clicking "Variables" tab, you'll see:**
   ```
   [Empty state or existing variables]
   [+ New Variable] button
   ```

2. **Click "+ New Variable" and you'll see:**
   ```
   Variable Name: [text input]
   Value: [text input]
   [Add] [Cancel]
   ```

3. **Fill in and click "Add"**

4. **Repeat until all 6 are added**

---

## Verification Checklist

After setting all variables, verify:

- [ ] `APP_KEYS` is set (4 comma-separated values)
- [ ] `ADMIN_JWT_SECRET` is set
- [ ] `API_TOKEN_SALT` is set
- [ ] `TRANSFER_TOKEN_SALT` is set
- [ ] `ENCRYPTION_KEY` is set
- [ ] `NODE_ENV` is set to `production`
- [ ] `DATABASE_URL` appears automatically (after adding PostgreSQL)
- [ ] `PORT` is automatically set by Railway

---

## Important Notes

1. **Never commit these secrets to GitHub** - They're already in `.gitignore`
2. **Generate new secrets for production** - Don't reuse development secrets
3. **Keep your secrets safe** - Store them in a password manager if needed
4. **If you change secrets** - Your app will redeploy automatically
5. **Railway encrypts variables** - They're stored securely

---

## Troubleshooting

### Variable Not Appearing?
- Make sure you're in the correct service (not the database service)
- Refresh the page
- Check if you saved the variable

### App Won't Start?
- Check Railway logs to see which variable is missing
- Verify all 6 required variables are set
- Make sure there are no extra spaces in variable names or values

### Database Connection Error?
- Verify PostgreSQL service is added
- Check that `DATABASE_URL` appears automatically
- If not, you may need to link the services manually

