param(
  [Parameter(Mandatory = $true)]
  [string]$Store,
  [Parameter(Mandatory = $true)]
  [string]$Token,
  [string]$CsvPath = "./product-whitening-import.csv"
)

$ErrorActionPreference = 'Stop'
$base = "https://$Store.myshopify.com/admin/api/2024-10"
$headers = @{
  'X-Shopify-Access-Token' = $Token
  'Content-Type' = 'application/json'
}

if (-not (Test-Path $CsvPath)) {
  throw "CSV file not found: $CsvPath"
}

$rows = Import-Csv -Path $CsvPath

foreach ($row in $rows) {
  $payload = @{
    product = @{
      title = $row.Title
      body_html = $row.'Body HTML'
      vendor = $row.Vendor
      product_type = $row.'Product Type'
      tags = $row.Tags
      published = [bool]::Parse($row.Published)
      variants = @(@{
        option1 = $row.'Option1 Value'
        price = [decimal]$row.Price
        compare_at_price = if ([string]::IsNullOrWhiteSpace($row.'Compare At Price')) { $null } else { [decimal]$row.'Compare At Price' }
        requires_shipping = [bool]::Parse($row.'Requires Shipping')
        inventory_policy = $row.'Inventory Policy'
        inventory_management = if ([string]::IsNullOrWhiteSpace($row.'Inventory Management')) { $null } else { $row.'Inventory Management' }
        taxable = [bool]::Parse($row.Taxable)
      })
    }
  } | ConvertTo-Json -Depth 10

  try {
    $response = Invoke-RestMethod -Method Post -Uri "$base/products.json" -Headers $headers -Body $payload
    Write-Host "Created product: $($response.product.title)"
  }
  catch {
    Write-Warning "Failed to create $($row.Title): $($_.Exception.Message)"
  }
}
