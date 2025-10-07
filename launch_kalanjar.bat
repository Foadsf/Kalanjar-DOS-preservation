@echo off
REM Launch DOSBox-X with optimal settings for Kalanjar
"C:\DOSBox-X\dosbox-x.exe" ^
  -set "output=direct3d" ^
  -c "mount c %CD%" ^
  -c "c:" ^
  -c "cd dos" ^
  -c "run.bat"