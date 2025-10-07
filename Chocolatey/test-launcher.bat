@echo off
setlocal

echo === Testing Kalanjar Launcher Detection Logic ===
echo.

REM Check for DOSBox-X in various locations
set "_DBX="

REM Check Chocolatey installation
echo Checking: C:\DOSBox-X\dosbox-x.exe
if exist "C:\DOSBox-X\dosbox-x.exe" (
    set "_DBX=C:\DOSBox-X\dosbox-x.exe"
    echo FOUND: C:\DOSBox-X\dosbox-x.exe
    goto :found
)
echo Not found

echo Checking: %ProgramFiles%\DOSBox-X\dosbox-x.exe
if exist "%ProgramFiles%\DOSBox-X\dosbox-x.exe" (
    set "_DBX=%ProgramFiles%\DOSBox-X\dosbox-x.exe"
    echo FOUND: %ProgramFiles%\DOSBox-X\dosbox-x.exe
    goto :found
)
echo Not found

echo Checking: %ProgramFiles(x86)%\DOSBox-X\dosbox-x.exe
if exist "%ProgramFiles(x86)%\DOSBox-X\dosbox-x.exe" (
    set "_DBX=%ProgramFiles(x86)%\DOSBox-X\dosbox-x.exe"
    echo FOUND: %ProgramFiles(x86)%\DOSBox-X\dosbox-x.exe
    goto :found
)
echo Not found

REM Check PATH
echo Checking PATH...
for %%F in (dosbox-x.exe) do if not "%%~$PATH:F"=="" (
    set "_DBX=%%~$PATH:F"
    echo FOUND in PATH: %%~$PATH:F
    goto :found
)
echo Not found in PATH

REM Check WinGet installation
echo Checking WinGet location...
for /d %%D in ("%LOCALAPPDATA%\Microsoft\WinGet\Packages\joncampbell123.DOSBox-X_*") do (
    if exist "%%D\dosbox-x.exe" (
        set "_DBX=%%D\dosbox-x.exe"
        echo FOUND: %%D\dosbox-x.exe
        goto :found
    )
)
echo Not found

REM Check Scoop installation
echo Checking: %USERPROFILE%\scoop\apps\dosbox-x\current\dosbox-x.exe
if exist "%USERPROFILE%\scoop\apps\dosbox-x\current\dosbox-x.exe" (
    set "_DBX=%USERPROFILE%\scoop\apps\dosbox-x\current\dosbox-x.exe"
    echo FOUND: %USERPROFILE%\scoop\apps\dosbox-x\current\dosbox-x.exe
    goto :found
)
echo Not found

:found
echo.
echo === Results ===
if "%_DBX%"=="" (
    echo FAILED: No DOSBox-X detected
    exit /b 1
) else (
    echo SUCCESS: DOSBox-X detected at:
    echo   %_DBX%
)

endlocal
