param(
  [Parameter(Mandatory = $true)]
  [string]$StoreUrl,
  [Parameter(Mandatory = $true)]
  [string]$AccessToken,
  [Parameter(Mandatory = $false)]
  [string]$ThemeId = "latest"
)

$ErrorActionPreference = 'Stop'

$storeName = $StoreUrl -replace '.*?/store/(.*?)(/.*)?$', '$1'

if (-not $storeName -or $storeName -eq $StoreUrl) {
  throw "Could not extract store name"
}

$baseUrl = "https://$storeName.myshopify.com/admin/api/2024-10"
$headers = @{
  'X-Shopify-Access-Token' = $AccessToken
  'Content-Type' = 'application/json'
}

Write-Host "Deploying theme files to Shopify..." -ForegroundColor Green
Write-Host "Store: $storeName" -ForegroundColor Cyan

if ($ThemeId -eq "latest") {
  $themesResponse = Invoke-RestMethod -Uri "$baseUrl/themes.json" -Headers $headers -Method Get
  $liveTheme = $themesResponse.themes | Where-Object { $_.role -eq "main" }
  $ThemeId = $liveTheme.id
  Write-Host "Found live theme: $($liveTheme.name) (ID: $ThemeId)" -ForegroundColor Green
}

$filesToUpload = @(
  "assets/base.css",
  "assets/theme.js",
  "sections/lorez-beauty-landing.liquid",
  "sections/contact-form.liquid",
  "sections/quote-cta.liquid",
  "sections/main-product.liquid",
  "sections/main-collection.liquid",
  "layout/theme.liquid",
  "config/settings_schema.json",
  "locales/en.default.json",
  "templates/index.json",
  "templates/product.json",
  "templates/collection.json",
  "templates/page.contact.json"
)

$successCount = 0
$failureCount = 0

foreach ($file in $filesToUpload) {
  $filePath = Join-Path -Path (Get-Location) -ChildPath $file
  
  if (-not (Test-Path $filePath)) {
    Write-Host "File not found: $file" -ForegroundColor Yellow
    $failureCount++
    continue
  }

  $fileContent = Get-Content -Path $filePath -Raw
  
  $payload = @{
    asset = @{
      key = $file
      value = $fileContent
    }
  } | ConvertTo-Json -Depth 10

  try {
    Invoke-RestMethod -Uri "$baseUrl/themes/$ThemeId/assets.json" -Headers $headers -Body $payload -Method Put | Out-Null
    Write-Host "Uploaded: $file" -ForegroundColor Green
    $successCount++
  }
  catch {
    Write-Host "Failed to upload $file : $($_.Exception.Message)" -ForegroundColor Red
    $failureCount++
  }

  Start-Sleep -Milliseconds 300
}

Write-Host ""
Write-Host "Deploy Complete!" -ForegroundColor Green
Write-Host "Uploaded: $successCount files" -ForegroundColor Green
if ($failureCount -gt 0) {
  Write-Host "Failed: $failureCount files" -ForegroundColor Red
}

