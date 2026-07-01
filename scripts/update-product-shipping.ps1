# Bulk-update product descriptions: replace €35 free shipping with €50
# Usage:
#   $env:SHOPIFY_STORE = "ibrcsh-ir"
#   $env:SHOPIFY_ADMIN_TOKEN = "shpat_..."
#   .\scripts\update-product-shipping.ps1

param(
  [string]$Store = $env:SHOPIFY_STORE,
  [string]$Token = $env:SHOPIFY_ADMIN_TOKEN
)

if (-not $Store -or -not $Token) {
  Write-Error "Set SHOPIFY_STORE and SHOPIFY_ADMIN_TOKEN environment variables first."
  exit 1
}

function Fix-ShippingCopy([string]$html) {
  $html = $html -replace 'Envío gratuito a partir de 35 €','Envío gratuito a partir de 50 €'
  $html = $html -replace 'Envío gratuito a partir de 35€','Envío gratuito a partir de 50€'
  $html = $html -replace 'envío gratuito a partir de 35 €','envío gratuito a partir de 50 €'
  $html = $html -replace 'a partir de 35 €','a partir de 50 €'
  $html = $html -replace 'a partir de 35€','a partir de 50€'
  $html = $html -replace 'desde 35 €','desde 50 €'
  $html = $html -replace 'superiores a 35 €','superiores a 50 €'
  $html = $html -replace 'inferiores a 35 €','inferiores a 50 €'
  return $html
}

$headers = @{
  'X-Shopify-Access-Token' = $Token
  'Content-Type' = 'application/json'
}

$base = "https://$Store.myshopify.com/admin/api/2024-10"
$products = @()
$url = "$base/products.json?limit=250"
while ($url) {
  $resp = Invoke-RestMethod -Uri $url -Headers $headers
  $products += $resp.products
  $url = $null
}

$updated = 0
foreach ($product in $products) {
  if ($product.body_html -notmatch '35\s*€|a partir de 35|desde 35|superiores a 35|inferiores a 35') { continue }
  $fixed = Fix-ShippingCopy $product.body_html
  $body = @{ product = @{ id = $product.id; body_html = $fixed } } | ConvertTo-Json -Depth 5
  Invoke-RestMethod -Method Put -Uri "$base/products/$($product.id).json" -Headers $headers -Body $body | Out-Null
  $updated++
  Write-Output "Updated: $($product.title)"
}

Write-Output "Done. Updated $updated products."
