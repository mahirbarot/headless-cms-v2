# PowerShell script to generate all required Strapi secrets for Railway
# Run this script: .\generate-secrets.ps1

Write-Host "`n=== Strapi Environment Variables for Railway ===`n" -ForegroundColor Cyan

# Function to generate a random base64 string
function Generate-RandomBase64 {
    $bytes = New-Object byte[] 32
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $rng.GetBytes($bytes)
    return [Convert]::ToBase64String($bytes)
}

# Generate APP_KEYS (4 comma-separated keys)
$appKeys = (1..4 | ForEach-Object { Generate-RandomBase64 }) -join ','

# Generate other secrets
$adminJwtSecret = Generate-RandomBase64
$apiTokenSalt = Generate-RandomBase64
$transferTokenSalt = Generate-RandomBase64
$encryptionKey = Generate-RandomBase64

Write-Host "Copy these values and add them in Railway Dashboard → Variables:`n" -ForegroundColor Yellow

Write-Host "1. APP_KEYS" -ForegroundColor Green
Write-Host "   $appKeys`n"

Write-Host "2. ADMIN_JWT_SECRET" -ForegroundColor Green
Write-Host "   $adminJwtSecret`n"

Write-Host "3. API_TOKEN_SALT" -ForegroundColor Green
Write-Host "   $apiTokenSalt`n"

Write-Host "4. TRANSFER_TOKEN_SALT" -ForegroundColor Green
Write-Host "   $transferTokenSalt`n"

Write-Host "5. ENCRYPTION_KEY" -ForegroundColor Green
Write-Host "   $encryptionKey`n"

Write-Host "6. NODE_ENV" -ForegroundColor Green
Write-Host "   production`n"

Write-Host "`n=== Railway CLI Commands (Optional) ===`n" -ForegroundColor Cyan
Write-Host "railway variables set APP_KEYS=`"$appKeys`""
Write-Host "railway variables set ADMIN_JWT_SECRET=`"$adminJwtSecret`""
Write-Host "railway variables set API_TOKEN_SALT=`"$apiTokenSalt`""
Write-Host "railway variables set TRANSFER_TOKEN_SALT=`"$transferTokenSalt`""
Write-Host "railway variables set ENCRYPTION_KEY=`"$encryptionKey`""
Write-Host "railway variables set NODE_ENV=`"production`""
Write-Host "`n"

