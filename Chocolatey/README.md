# kalanjar - Persian DOS Chatbot for Windows

A Chocolatey package that installs Kalanjar (کلنجار), a historic Persian chatbot from 1992-1993, with a launcher that automatically runs it in DOSBox-X with proper text rendering.

## About Kalanjar

Kalanjar is one of the earliest examples of Persian-language conversational AI, created by **Farhad Dadgostar** at Isfahan University of Technology. This package preserves this piece of computing history and makes it easily accessible on modern Windows systems.

## Installation

```powershell
choco install kalanjar
```

## Usage

Navigate to any directory and run:

```cmd
kalanjar
```

The chatbot will launch in DOSBox-X with:
- **C:** mounted to your current working directory
- **D:** mounted to the Kalanjar installation directory
- Proper Persian text rendering configured automatically

## Requirements

- DOSBox-X (automatically installed as a dependency)

## Features

- Historic Persian DOS chatbot from the early 1990s
- Automatic DOSBox-X configuration for proper Persian text display
- Text-mode rendering with correct box-drawing characters
- Works from any directory
- No manual configuration required

## Technical Details

The launcher automatically:
- Detects DOSBox-X from multiple installation sources (Chocolatey, WinGet, Scoop, PATH)
- Sets output mode to OpenGL for proper text-mode rendering
- Mounts directories appropriately
- Launches KLUDGE.EXE via the DOS RUN.BAT script

## Development and Testing

### Building from Source

```powershell
cd C:\dev\DOS\20250904\kalanjar\github\Chocolatey
choco pack
choco install kalanjar -s "." -y
```

### Testing with Sandboxie-Plus

When testing in Sandboxie-Plus, clear the cache to ensure changes take effect:

```powershell
# On host machine
Remove-Item -Recurse -Force "C:\Sandbox\<User>\<BoxName>\user\all\chocolatey\lib\kalanjar" -ErrorAction SilentlyContinue

# Inside sandbox
choco uninstall kalanjar -y
choco pack
choco install kalanjar -s "." -y --force
```

**Helper script** (`test-install.ps1`):

```powershell
# Clean up completely
choco uninstall kalanjar -y 2>$null
Remove-Item -Recurse -Force "$env:ChocolateyInstall\lib\kalanjar" -ErrorAction SilentlyContinue

# Build fresh package
choco pack

# Install from local source
choco install kalanjar -s "." -y --force
```

### Testing Detection Logic

Before building the package, test the DOSBox-X detection:

```powershell
# PowerShell detection test
.\test-detection.ps1

# Batch launcher test
.\test-launcher.bat
```

## File Hashes

**Archive:**
- SHA256: `5400225CDC4125811C32E02FA61E42D120DE5522A43F579E04DCCDF2175C9A8B1`

**DOS Executable:**
- `DOS\KLUDGE.EXE`: `4eb8805401645ceb7e60b7e476e1e87a9fc3142987976ee69ca6b88c6361922c`

**Windows Wrapper:**
- `Win_XP\kalanjar.exe`: `86439cb8a6ffcb449d881d3bd901f4cefa11007ec8c4bf45f14fcc6d602fd8ac`

## Credits

- **Original Author:** Farhad Dadgostar ([LinkedIn](https://www.linkedin.com/in/fdadgostar/))
- **Package Maintainer:** Foadsf
- **Source Repository:** [Kalanjar-DOS-preservation](https://github.com/Foadsf/Kalanjar-DOS-preservation)

## License

Original software copyright © 1992-1993 Farhad Dadgostar. Package maintained for historical preservation purposes.

## Links

- [Source Repository](https://github.com/Foadsf/Kalanjar-DOS-preservation)
- [Release Notes](https://github.com/Foadsf/Kalanjar-DOS-preservation/releases)
- [Chocolatey Package](https://community.chocolatey.org/packages/kalanjar) (pending)
