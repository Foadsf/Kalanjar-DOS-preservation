# Kalanjar (کلنجار) — Persian DOS-era Chatbot (Preservation Notes)

**Kalanjar** is an early Persian (Farsi) chatbot from the MS-DOS era (circa 1992–1993).
It opens in a text UI and chats in Persian. The splash screen credits **Farhad Dadgostar** (Isfahan University of Technology).

> **Attribution:** Created by **Farhad Dadgostar**
> LinkedIn: https://www.linkedin.com/in/fdadgostar/

This repo preserves setup notes for running Kalanjar on a modern Windows PC with DOSBox-X.

![Screenshot](images/screenshot.png)

---

## 🚀 Quick Start (Windows)

1. **Download DOSBox-X** from https://dosbox-x.com/
2. **Download the latest release** from [Releases](https://github.com/Foadsf/Kalanjar-DOS-preservation/releases)
3. **Extract** the archive
4. **Run** `launch_kalanjar.bat`

That's it! Kalanjar will start automatically with proper Persian text rendering.

---

## 📁 What's Included

The archive contains two variants:

```
kalanjar/
├─ launch_kalanjar.bat    ← One-click launcher
├─ DOS/                    ← Original DOS build
│   ├─ KLUDGE.EXE         ← Main executable
│   ├─ Run.bat            ← DOS launcher script
│   └─ *.DAT              ← Language/logic files
└─ Win_XP/                ← Windows port/wrapper
    └─ kalanjar.exe       ← May need VB6 runtime
```

### File Hashes (SHA-256)

- `DOS\KLUDGE.EXE` → `4eb8805401645ceb7e60b7e476e1e87a9fc3142987976ee69ca6b88c6361922c`
- `WIN_XP\kalanjar.exe` → `86439cb8a6ffcb449d881d3bd901f4cefa11007ec8c4bf45f14fcc6d602fd8ac`

*(Verify with: `certutil -hashfile "path\to\file" SHA256`)*

---

## 🔧 Manual Setup

If you want to run manually or customize the setup:

### Launch DOSBox-X
```cmd
"C:\DOSBox-X\dosbox-x.exe" -set "output=opengl" -c "mount c %CD%" -c "c:"
```

### Inside DOSBox-X
```dos
cd dos
run
```

### Technical Notes

- **Output mode:** Use OpenGL, Surface, or Direct3D (NOT TrueType font mode)
- **Why it works:** DOSBox-X's text-mode rendering correctly emulates VGA character cells and CP864 codepage
- **No special fonts needed:** Box-drawing characters render correctly with standard text mode

---

## 🔐 Security Check (Optional)

Scan with Windows Defender:
```cmd
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File "path\to\kalanjar"
```

Verify file hashes:
```cmd
certutil -hashfile "DOS\KLUDGE.EXE" SHA256
certutil -hashfile "WIN_XP\kalanjar.exe" SHA256
```

---

## 🐛 Troubleshooting

### Text appears garbled
- Make sure you're using the `launch_kalanjar.bat` file
- If running manually, check that output mode is NOT set to TrueType

### Box-drawing characters broken
- Switch to OpenGL/Surface/Direct3D output mode
- Avoid using TrueType font rendering

### Windows version doesn't work
- The Win_XP version may require Visual Basic 6 runtime
- Set "Language for non-Unicode programs" to Persian (Iran) in Windows settings
- Prefer the DOS version for better compatibility

---

## 📚 Background

Kalanjar is a historical curiosity — an early attempt at Persian conversational AI using simple rule-based logic. Think ELIZA, but in Farsi from early 1990s Iran.

The program demonstrates the technical challenges of Persian computing in the DOS era:
- Right-to-left text rendering
- Custom codepage handling (CP864)
- Text-mode UI design for Persian script

---

## 🙏 Credits

- **Original author:** Farhad Dadgostar — [LinkedIn](https://www.linkedin.com/in/fdadgostar/)
- **Preservation:** Community effort, special thanks to contributors on Persian Computing forums

If you own rights to Kalanjar and want us to update/remove files or adjust attribution, please open an issue.

---

## 📜 License

Archival/preservation purposes. Original copyright remains with Farhad Dadgostar.

---

**Want to contribute?** Open an issue or pull request!
