$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$packageDir = Split-Path -Parent $toolsDir

Write-Host "Starting Kalanjar installation..."

# Check for existing DOSBox-X installation from various sources
$dosboxPath = $null

# Check common installation paths
$possiblePaths = @(
    "C:\DOSBox-X\dosbox-x.exe",
    "$env:ProgramFiles\DOSBox-X\dosbox-x.exe",
    "${env:ProgramFiles(x86)}\DOSBox-X\dosbox-x.exe",
    "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\joncampbell123.DOSBox-X_*\dosbox-x.exe",
    "$env:USERPROFILE\scoop\apps\dosbox-x\current\dosbox-x.exe"
)

foreach ($path in $possiblePaths) {
    $resolved = Resolve-Path $path -ErrorAction SilentlyContinue
    if ($resolved) {
        $dosboxPath = $resolved.Path
        Write-Host "Found existing DOSBox-X at: $dosboxPath"
        break
    }
}

# Check PATH
if (-not $dosboxPath) {
    $pathCmd = Get-Command dosbox-x.exe -ErrorAction SilentlyContinue
    if ($pathCmd) {
        $dosboxPath = $pathCmd.Source
        Write-Host "Found DOSBox-X in PATH: $dosboxPath"
    }
}

# If no existing installation found, DOSBox-X will be installed via dependency
if (-not $dosboxPath) {
    Write-Host "No existing DOSBox-X installation found. It will be installed as a dependency."
}

# Download Kalanjar from GitHub release
$params = @{
    PackageName  = 'kalanjar'
    Url          = 'https://github.com/Foadsf/Kalanjar-DOS-preservation/releases/download/v1.1.0/kalanjar-original-dos-winxp.zip'
    FileFullPath = (Join-Path $toolsDir 'kalanjar.zip')
    Checksum     = 'C8051C2878BAEDE1B4F655E9FAC0E459A9D75C53ADA9AC6016D7E2C0723BCAC0'
    ChecksumType = 'sha256'
}

Get-ChocolateyWebFile @params

# Extract to kalanjar directory
$extractPath = Join-Path $toolsDir 'kalanjar'
Get-ChocolateyUnzip -FileFullPath (Join-Path $toolsDir 'kalanjar.zip') -Destination $extractPath

# Create .ignore files to prevent Chocolatey from shimming the extracted executables
$ignoreFiles = @(
    (Join-Path $extractPath 'DOS\KLUDGE.EXE.ignore'),
    (Join-Path $extractPath 'Win_XP\kalanjar.exe.ignore')
)

foreach ($ignoreFile in $ignoreFiles) {
    New-Item -ItemType File -Path $ignoreFile -Force | Out-Null
}

Write-Host "Created .ignore files to prevent automatic shimming of executables"

# Copy the launcher batch file from package directory to tools
$sourceLauncher = Join-Path $packageDir 'kalanjar-launcher.bat'
$targetLauncher = Join-Path $toolsDir 'kalanjar.bat'

if (Test-Path $sourceLauncher) {
    Copy-Item -Path $sourceLauncher -Destination $targetLauncher -Force
    Write-Host "Copied launcher batch file to tools directory"
}
else {
    Write-Warning "Launcher batch file not found at: $sourceLauncher"
    Write-Warning "Installation may not work correctly"
}

Write-Host "Creating shim for kalanjar.bat..."
Install-BinFile -Name 'kalanjar' -Path $targetLauncher

Write-Host "Kalanjar installation complete!"
Write-Host "Run 'kalanjar' from any directory to start the chatbot."
