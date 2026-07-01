# Plan A — Shopify Admin checklist (jouw stappen)

Volg deze volgorde in Shopify Admin. Vink af terwijl je gaat.

## Stap 1 — Archiveren (~15 min)

**Producten** → zoek en selecteer → **Meer acties** → **Archiveren**:

- Q10 / espuma limpiadora
- Ice roller set (6-piece)
- V-Line / chin strap
- Sugar scrub / azúcar exfoliator
- Sadoer collagen sheet masks (5/10/20/30 pcs)
- 24K pure gold sleeping mask (niet de peel-off)
- Golden eye mask 60 pcs
- Collagen wrapping mask + brush

## Stap 2 — Voorraad (~10 min)

Per routine-product → **Voorraad** → **Doorgaan met verkopen als niet op voorraad** = AAN:

1. Gel Tea Tree
2. Parches SOS
3. Caja Mascarillas Colágeno x4
4. Mascarilla Jelly Cereza
5. Discos Tónicos
6. Crema Colágeno
7. Protector Solar SPF50
8. Set Centella
9. Mascarilla Oro 24K peel-off

## Stap 3 — CSV import (~5 min)

**Producten** → **Importeren** → upload `product-routine-launch.csv`  
→ **Producten bijwerken met overeenkomende handles** → Start import

Dit zet Spaanse titels, beschrijvingen, prijzen en foto-volgorde voor de 4 nieuwe producten.  
**Geen compare-at prijzen** (Omnibus-compliant).

## Stap 4 — Compare-at verwijderen op ALLE producten (~10 min)

Per actief product → prijs → wis het veld **Vergelijkingsprijs** / **Compare-at price** → Opslaan.

## Stap 5 — Foto's opschonen (~30 min)

Zie `product-media-guide.json`. Per nieuw product max 4–5 foto's, geen merklogo's.

## Stap 6 — CJ koppelen (~15 min)

**Apps** → **CJ Dropshipping** → koppel alle 9+ routine-producten.

## Stap 7 — Theme live

Push theme naar GitHub (of vraag agent om commit + push).  
Shopify sync't automatisch → nieuwe homepage + premium productpagina's.

## Stap 8 — Test

Op lorezbeauty.com: add-to-cart op elk routine-product + kit-knop homepage.

---

*Automatische API-update (optioneel):*

```powershell
$env:SHOPIFY_STORE = "ibrcsh-ir"
$env:SHOPIFY_ADMIN_TOKEN = "shpat_..."
.\scripts\update-routine-products.ps1
```

Dit zet titels, prijzen, voorraadbeleid en wist compare-at voor de 4 nieuwe producten.
