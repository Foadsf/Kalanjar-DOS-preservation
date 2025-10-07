@echo off
setlocal

REM Kalanjar Launcher for DOSBox-X
REM Detects DOSBox-X installation and launches Kalanjar with proper configuration

set "_DBX="

REM Check Chocolatey installation
if exist "C:\DOSBox-X\dosbox-x.exe" set "_DBX=C:\DOSBox-X\dosbox-x.exe"
if not "%_DBX%"=="" goto :found

REM Check Program Files
if exist "%ProgramFiles%\DOSBox-X\dosbox-x.exe" set "_DBX=%ProgramFiles%\DOSBox-X\dosbox-x.exe"
if not "%_DBX%"=="" goto :found

if exist "%ProgramFiles(x86)%\DOSBox-X\dosbox-x.exe" set "_DBX=%ProgramFiles(x86)%\DOSBox-X\dosbox-x.exe"
if not "%_DBX%"=="" goto :found

REM Check PATH
for %%F in (dosbox-x.exe) do (
    if not "%%~$PATH:F"=="" (
        set "_DBX=%%~$PATH:F"
        goto :found
    )
)

REM Check WinGet installation
for /d %%D in ("%LOCALAPPDATA%\Microsoft\WinGet\Packages\joncampbell123.DOSBox-X_*") do (
    if exist "%%D\dosbox-x.exe" (
        set "_DBX=%%D\dosbox-x.exe"
        goto :found
    )
)

REM Check Scoop installation
if exist "%USERPROFILE%\scoop\apps\dosbox-x\current\dosbox-x.exe" (
    set "_DBX=%USERPROFILE%\scoop\apps\dosbox-x\current\dosbox-x.exe"
    goto :found
)

REM Not found
echo ERROR: DOSBox-X not found. Please install it via:
echo   - Chocolatey: choco install dosbox-x
echo   - WinGet:     winget install joncampbell123.DOSBox-X
echo   - Scoop:      scoop install dosbox-x
exit /b 1

:found
REM Get the directory where this batch file is located
set "_KALANJAR_ROOT=%~dp0kalanjar"
set "_DOS_DIR=%_KALANJAR_ROOT%\DOS"

REM Launch DOSBox-X with proper configuration
REM The key change: cd to D: (the DOS directory) before running run.bat
"%_DBX%" ^
  -set "output=opengl" ^
  -c "mount c \"%CD%\"" ^
  -c "mount d \"%_DOS_DIR%\"" ^
  -c "c:" ^
  -c "d:" ^
  -c "run.bat"

endlocal
