$ErrorActionPreference = 'SilentlyContinue'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "Uninstalling Kalanjar..."

Remove-Item -Recurse -Force (Join-Path $toolsDir 'kalanjar') -ErrorAction SilentlyContinue
Remove-Item -Force (Join-Path $toolsDir 'kalanjar.zip') -ErrorAction SilentlyContinue
Remove-Item -Force (Join-Path $toolsDir 'kalanjar.bat') -ErrorAction SilentlyContinue

Write-Host "Kalanjar uninstalled successfully."
