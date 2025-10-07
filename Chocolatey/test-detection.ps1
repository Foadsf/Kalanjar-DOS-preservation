# Test script to verify DOSBox-X detection logic
Write-Host "=== Testing DOSBox-X Detection Logic for Kalanjar ===" -ForegroundColor Cyan
Write-Host ""

$dosboxPath = $null

# Check common installation paths
$possiblePaths = @(
    "C:\DOSBox-X\dosbox-x.exe",
    "$env:ProgramFiles\DOSBox-X\dosbox-x.exe",
    "${env:ProgramFiles(x86)}\DOSBox-X\dosbox-x.exe",
    "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\joncampbell123.DOSBox-X_*\dosbox-x.exe",
    "$env:USERPROFILE\scoop\apps\dosbox-x\current\dosbox-x.exe"
)

Write-Host "Checking predefined paths:" -ForegroundColor Yellow
foreach ($path in $possiblePaths) {
    Write-Host "  Checking: $path"
    $resolved = Resolve-Path $path -ErrorAction SilentlyContinue
    if ($resolved) {
        $dosboxPath = $resolved.Path
        Write-Host "  ✓ FOUND: $dosboxPath" -ForegroundColor Green
        break
    }
    else {
        Write-Host "  ✗ Not found" -ForegroundColor DarkGray
    }
}

# Check PATH
if (-not $dosboxPath) {
    Write-Host "`nChecking PATH environment:" -ForegroundColor Yellow
    $pathCmd = Get-Command dosbox-x.exe -ErrorAction SilentlyContinue
    if ($pathCmd) {
        $dosboxPath = $pathCmd.Source
        Write-Host "  ✓ FOUND in PATH: $dosboxPath" -ForegroundColor Green
    }
    else {
        Write-Host "  ✗ Not found in PATH" -ForegroundColor DarkGray
    }
}

# Summary
Write-Host "`n=== Results ===" -ForegroundColor Cyan
if ($dosboxPath) {
    Write-Host "SUCCESS: DOSBox-X detected at:" -ForegroundColor Green
    Write-Host "  $dosboxPath"

    # Verify it actually exists and is executable
    if (Test-Path $dosboxPath) {
        Write-Host "`nFile verification:" -ForegroundColor Yellow
        $fileInfo = Get-Item $dosboxPath
        Write-Host "  Size: $($fileInfo.Length) bytes"
        Write-Host "  Modified: $($fileInfo.LastWriteTime)"
    }
}
else {
    Write-Host "FAILED: No DOSBox-X installation detected" -ForegroundColor Red
    Write-Host "`nPlease verify DOSBox-X is installed via one of:" -ForegroundColor Yellow
    Write-Host "  - WinGet:     winget install joncampbell123.DOSBox-X"
    Write-Host "  - Chocolatey: choco install dosbox-x"
    Write-Host "  - Scoop:      scoop install dosbox-x"
}
