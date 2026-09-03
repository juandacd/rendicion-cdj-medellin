# Regenera publicar\index.html a partir del reporte principal.
# Uso: abrir PowerShell en la carpeta "REPORTE M180" y ejecutar:  .\publicar\actualizar.ps1
$origen  = Join-Path $PSScriptRoot "..\Reporte_Gestion_CDJ_M180.html"
$destino = Join-Path $PSScriptRoot "index.html"

$html = Get-Content -Path $origen -Raw -Encoding UTF8
$html = $html -replace [regex]::Escape('href="02_IMAGENES_AVANCES/entrega%20concepto%20ctp%20video.mov"'), 'href="videos/entrega-concepto-ctp.mp4"'
$html = $html -replace [regex]::Escape('href="02_IMAGENES_AVANCES/sesion%20conjunta%20concejo%20de%20medellin.mp4"'), 'href="videos/sesion-concejo-medellin.mp4"'
$html = $html -replace [regex]::Escape('Clic para abrir el video de la carpeta.'), 'Clic para ver el video.'

$utf8SinBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($destino, $html, $utf8SinBom)
Write-Host "index.html actualizado." -ForegroundColor Green
