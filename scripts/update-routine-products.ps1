# Update Lorez Beauty routine products: titles, prices, descriptions, image order
# Usage:
#   $env:SHOPIFY_STORE = "ibrcsh-ir"
#   $env:SHOPIFY_ADMIN_TOKEN = "shpat_..."
#   .\scripts\update-routine-products.ps1

param(
  [string]$Store = $env:SHOPIFY_STORE,
  [string]$Token = $env:SHOPIFY_ADMIN_TOKEN,
  [switch]$WhatIf
)

if (-not $Store -or -not $Token) {
  Write-Error "Set SHOPIFY_STORE and SHOPIFY_ADMIN_TOKEN first."
  exit 1
}

$headers = @{
  'X-Shopify-Access-Token' = $Token
  'Content-Type'           = 'application/json'
}
$base = "https://$Store.myshopify.com/admin/api/2024-10"

function Get-ShippingBlock {
  @"
<hr>
<h3>📦 Envío y Entrega</h3>
<p>Preparamos tu pedido en <strong>1 a 2 días laborables</strong>. El plazo de entrega habitual es de <strong>7 a 14 días laborables</strong> en España y <strong>10 a 18 días laborables</strong> en México. Recibirás un correo con el número de seguimiento en cuanto tu pedido sea enviado.</p>
<p>✅ <strong>Envío gratuito a partir de 50 €</strong><br>🔄 <strong>Garantía de devolución de 30 días.</strong> Si no quedas satisfecho, contacta con nosotros.<br>🔒 <strong>Pago 100 % seguro</strong> con PayPal, Visa, Mastercard, Apple Pay y Google Pay.</p>
"@
}

$shipping = Get-ShippingBlock

$catalog = @(
  @{
    handle       = 'acanthosis-nigricans-cleansing-lotion-moisturizes-and-exfoliates'
    title        = 'Gel Limpiador Tea Tree Anti-Acné'
    price        = '22.95'
    tags         = 'rutina-mañana, rutina-noche, anti-acne, limpiador, clear-skin, lorez-beauty'
    video        = $false
    imageOrder   = @(
      'https://cf.cjdropshipping.com/17179776/2406100827470323000.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/77155de9-b739-4949-94d6-3c8ceca9088f.jpg'
    )
    body         = @"
<p><strong>Gel Limpiador Tea Tree Anti-Acné</strong></p>
<p><strong>Limpieza profunda sin resecar. Para piel con acné y poros dilatados.</strong></p>
<p>Gel limpiador con <strong>aceite de árbol de té</strong>, extracto de pomelo y ácido cítrico. Elimina impurezas, exceso de grasa y residuos sin irritar. Ideal como primer paso de tu rutina <strong>mañana y noche</strong>.</p>
<h3>Lo que notarás</h3>
<ul>
<li>Piel más fresca y limpia desde la primera aplicación</li>
<li>Menos brillos y poros con aspecto más refinado</li>
<li>Textura ligera que no deja sensación pegajosa</li>
<li>Calma la piel propensa al acné con uso diario</li>
</ul>
<p><strong>50 ml</strong> — Uso diario, mañana y noche.</p>
<p><strong>Cómo usar:</strong> Aplica sobre la piel húmeda, masajea suavemente 30 segundos y aclara con agua tibia.</p>
$shipping
"@
  }
  @{
    handle       = 'acne-stickers-fade-acne-marks'
    title        = 'Parches Anti-Acné Hidrocoloide (SOS)'
    price        = '14.95'
    tags         = 'rutina-noche, parches, sos, anti-acne, clear-skin, lorez-beauty'
    video        = $false
    imageOrder   = @(
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/1247473137180.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/8b1855da-3573-4cf3-aa31-3de33bf52c87.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/f267a4c7-7788-4964-9436-77d30e6908cf.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/18822629795829.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/1465159638141.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/423491234363.jpg'
    )
    body         = @"
<p><strong>Parches Anti-Acné Hidrocoloide (SOS)</strong></p>
<p><strong>Tratamiento localizado para granos y imperfecciones. Día y noche.</strong></p>
<p>Parches ultrafinos de <strong>hidrocoloide</strong> con aceite de árbol de té y caléndula. Absorben la secreción del grano, protegen la zona y aceleran la recuperación sin marcas.</p>
<h3>Lo que notarás</h3>
<ul>
<li>Parches transparentes y discretos (0,1–0,3 mm)</li>
<li>Protección frente a polvo, bacterias y maquillaje</li>
<li>Tres tamaños (8 mm, 10 mm, 12 mm) para distintos tipos de imperfección</li>
<li>Ideal como último paso de la rutina nocturna</li>
</ul>
<p><strong>25–28 parches</strong> — Uso puntual cuando aparece un grano.</p>
<p><strong>Cómo usar:</strong> Limpia y seca la zona. Aplica el parche directamente sobre el grano. Déjalo actuar varias horas o toda la noche. Retira con cuidado.</p>
$shipping
"@
  }
  @{
    handle       = 'face-mask-shrink-pore-moisturizing-refreshing-brightening-firming-lift-nourish-skin-care-deep-hydration-moisturizer'
    title        = 'Caja Mascarillas Colágeno x4'
    price        = '27.95'
    tags         = 'tratamiento-semanal, mascarilla, colageno, clear-skin, lorez-beauty'
    video        = $true
    videoNote    = 'CJ → Face Mask product page → Gallery → download MP4 → Shopify Media'
    imageOrder   = @(
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/ffd340bc-6fbd-4a16-9d7b-d61c338b9184.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/6e1f0aed-787e-4a9f-aa35-bb5a94c5a51c.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/bac4a72e-d01a-46b5-9e20-5027e7bcbc97.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/79d4ad95-8181-466f-83b1-c883ef2c2da0.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/f47d2a97-54f3-4f72-92d6-f45c9f7ce966.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/de7cf169-37bd-4776-bb5c-40a092113132.jpg'
    )
    body         = @"
<p><strong>Caja Mascarillas Colágeno x4</strong></p>
<p><strong>Tratamiento semanal de hidratación profunda y firmeza.</strong></p>
<p>Mascarillas de colágeno de bajo peso molecular con ácido hialurónico y probióticos. Reducen la apariencia de poros, aportan luminosidad y dejan la piel más firme y suave.</p>
<h3>Lo que notarás</h3>
<ul>
<li>Hidratación intensa en 15–20 minutos</li>
<li>Piel más luminosa y uniforme</li>
<li>Efecto reafirmante con uso regular (1–2 veces por semana)</li>
<li>Textura gel que se adapta al contorno del rostro</li>
</ul>
<p><strong>4 mascarillas · 34 g cada una</strong> — Tratamiento semanal.</p>
<p><strong>Cómo usar:</strong> Limpia el rostro. Aplica la mascarilla 15–20 minutos. Retira y masajea el exceso de sérum. No aclares.</p>
$shipping
"@
  }
  @{
    handle       = 'cherry-flower-seaweed-mask-hydrating-jelly-glue-soft-mask-powder'
    title        = 'Mascarilla Jelly Peel-Off Cereza'
    price        = '24.95'
    tags         = 'tratamiento-semanal, peel-off, mascarilla, clear-skin, lorez-beauty'
    video        = $true
    videoNote    = 'CJ → Cherry Flower Seaweed Mask → Gallery → download MP4 → Shopify Media'
    imageOrder   = @(
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/5d796d69-571f-4d0b-93b1-173ba35ce2f1.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/0c7200e7-a47b-4106-817e-5e97d4411524.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/c9db1d94-256c-49f6-a27a-5c891010228d.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/c931e4bc-3f79-44d6-856f-feaba917ba17.jpg'
      'https://cdn.shopify.com/s/files/1/1054/1108/4625/files/88bf90b4-2137-4649-be95-92774439ea86.jpg'
    )
    body         = @"
<p><strong>Mascarilla Jelly Peel-Off Cereza</strong></p>
<p><strong>Ritual spa en casa. Peel-off modeling mask con cereza.</strong></p>
<p>Mascarilla modeling de gel con polvo de aminoácidos vegetales. Mezcla ambos componentes, aplica y retira en una sola pieza. Hidrata, calma y mejora la elasticidad de la piel.</p>
<h3>Lo que notarás</h3>
<ul>
<li>Piel más suave y luminosa al retirar la mascarilla</li>
<li>Efecto calmante e hidratante inmediato</li>
<li>Mejora la elasticidad con uso semanal</li>
<li>Experiencia sensorial tipo spa profesional</li>
</ul>
<p><strong>Gel 50 g + polvo 5 g</strong> — 1–2 aplicaciones por semana.</p>
<p><strong>Cómo usar:</strong> Mezcla el gel con el polvo hasta obtener textura homogénea. Aplica capa uniforme, evita cejas y labios. Espera 15–20 minutos y retira suavemente de abajo hacia arriba.</p>
$shipping
"@
  }
)

$products = (Invoke-RestMethod -Uri "$base/products.json?limit=250" -Headers $headers).products

foreach ($item in $catalog) {
  $product = $products | Where-Object { $_.handle -eq $item.handle } | Select-Object -First 1
  if (-not $product) {
    Write-Warning "Not found: $($item.handle)"
    continue
  }

  Write-Output "Processing: $($item.title)"

  if ($WhatIf) { continue }

  $variantId = $product.variants[0].id
  $variantBody = @{
    variant = @{
      id               = $variantId
      price            = $item.price
      compare_at_price = $null
      inventory_policy = 'continue'
    }
  } | ConvertTo-Json -Depth 5
  Invoke-RestMethod -Method Put -Uri "$base/variants/$variantId.json" -Headers $headers -Body $variantBody | Out-Null

  $productBody = @{
    product = @{
      id        = $product.id
      title     = $item.title
      body_html = $item.body
      tags      = $item.tags
      vendor    = 'Lorez Beauty'
    }
  } | ConvertTo-Json -Depth 5
  Invoke-RestMethod -Method Put -Uri "$base/products/$($product.id).json" -Headers $headers -Body $productBody | Out-Null

  $pos = 1
  foreach ($src in $item.imageOrder) {
    $existing = $product.images | Where-Object { $_.src -like "*$(Split-Path $src -Leaf)*" } | Select-Object -First 1
    if ($existing) {
      $imgBody = @{ image = @{ id = $existing.id; position = $pos } } | ConvertTo-Json -Depth 5
      Invoke-RestMethod -Method Put -Uri "$base/products/$($product.id)/images/$($existing.id).json" -Headers $headers -Body $imgBody | Out-Null
    }
    else {
      $imgBody = @{ image = @{ src = $src; position = $pos } } | ConvertTo-Json -Depth 5
      Invoke-RestMethod -Method Post -Uri "$base/products/$($product.id)/images.json" -Headers $headers -Body $imgBody | Out-Null
    }
    $pos++
  }

  if ($item.video) {
    Write-Output "  → Video: $($item.videoNote)"
  }

  Write-Output "  ✓ Updated"
}

Write-Output "Done."
