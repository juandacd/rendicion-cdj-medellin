<#
  publicar.ps1
  Regenera index.html a partir del reporte principal y lo sube a GitHub Pages.

  Uso:
    .\publicar.ps1
    .\publicar.ps1 "Agrega hito de la sesion con la Secretaria"
#>
param([string]$Mensaje = "Actualiza reporte")

$ErrorActionPreference = "Stop"

# --- 1. Regenerar index.html desde el reporte principal ---
& (Join-Path $PSScriptRoot "actualizar.ps1")

# --- 2. Subir a GitHub ---
Push-Location $PSScriptRoot
try {
    $cambios = git status --porcelain
    if ([string]::IsNullOrWhiteSpace($cambios)) {
        Write-Host "No hay cambios que subir. El sitio ya esta al dia." -ForegroundColor Yellow
    }
    else {
        git add .
        git commit -m $Mensaje
        git push
        Write-Host ""
        Write-Host "Publicado. GitHub Pages tarda 1-2 minutos en reflejarlo." -ForegroundColor Green
    }
}
finally {
    Pop-Location
}
