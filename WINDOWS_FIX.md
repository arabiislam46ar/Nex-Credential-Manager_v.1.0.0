# Windows Troubleshooting Guide

## সমস্যা ১: Splash Screen এ আটকে থাকা

### কারণ:
Config file corrupt বা empty হয়ে গেছে।

### সমাধান:
```bash
# AppData ফোল্ডারে যান এবং config.json ডিলিট করুন
del %APPDATA%\nex-credentials-manager\config.json

# অথবা পুরো ফোল্ডার ডিলিট করুন (সব ডেটা মুছে যাবে!)
rmdir /s %APPDATA%\nex-credentials-manager

# এরপর আবার চালান
npm start
```

### দ্রুত ফিক্স:
1. File Explorer খুলুন
2. এই পাথে যান: `C:\Users\YourUsername\AppData\Roaming\nex-credentials-manager`
3. `config.json` ফাইল ডিলিট করুন
4. আবার `npm start` করুন

---

## সমস্যা ২: Build করতে পারছি না (Symbolic Link Error)

### কারণ:
Windows এ symbolic link তৈরি করতে Administrator permission লাগে।

### সমাধান ১: Administrator হিসেবে চালান (সবচেয়ে সহজ)

1. **Command Prompt as Administrator খুলুন**:
   - Start Menu এ লিখুন "cmd"
   - Right-click করে "Run as administrator" সিলেক্ট করুন

2. **Project folder এ যান**:
   ```bash
   cd "E:\Backup 1\Codes\Nex Credential Manager\v.3.2.2\Nex-Credentials-Manager"
   ```

3. **Build করুন**:
   ```bash
   npm run build:win
   ```

### সমাধান ২: Developer Mode Enable করুন

1. **Windows Settings** খুলুন (`Win + I`)
2. **Privacy & Security** → **For developers** এ যান
3. **Developer Mode** চালু করুন
4. Computer restart করুন
5. এরপর normal Command Prompt থেকে build করুন:
   ```bash
   npm run build:win
   ```

### সমাধান ৩: PowerShell দিয়ে চালান

1. **PowerShell as Administrator** খুলুন
2. Project folder এ যান:
   ```powershell
   cd "E:\Backup 1\Codes\Nex Credential Manager\v.3.2.2\Nex-Credentials-Manager"
   ```
3. Build করুন:
   ```powershell
   npm run build:win
   ```

### সমাধান ৪: Cache Clear করুন

```bash
# Electron builder cache ডিলিট করুন
rmdir /s %LOCALAPPDATA%\electron-builder\Cache

# আবার build করুন
npm run build:win
```

---

## সমস্যা ৩: Build Error - "Access is denied" (d3dcompiler_47.dll)

### লক্ষণ:
```
⨯ remove dist\win-unpacked\d3dcompiler_47.dll: Access is denied.
```

### কারণ:
- dist folder এর files locked by Windows/Antivirus
- Previous build process still running
- File Explorer has dist folder open
- Windows Defender scanning files

### 🎯 সমাধান (Try করুন এই order এ):

#### সমাধান ১: Clean এবং Rebuild (সবচেয়ে সহজ) ✅

```bash
# Option A: Batch script use করুন
clean-build.bat ডাবল ক্লিক করুন

# Option B: npm command
npm run clean
npm run build:win
```

#### সমাধান ২: Manual Clean (যদি batch script কাজ না করে)

```bash
# 1. সব Electron process close করুন
taskkill /F /IM electron.exe
taskkill /F /IM app-builder.exe

# 2. কিছুক্ষণ wait করুন (important!)
timeout /t 5

# 3. dist folder ডিলিট করুন
rmdir /s /q dist

# 4. আবার build করুন
npm run build:win
```

#### সমাধান ৩: File Explorer বন্ধ করুন

1. **All File Explorer windows close করুন**
2. **Task Manager খুলুন** (Ctrl+Shift+Esc)
3. **"explorer.exe" select করে End Task** দিন
4. **File → Run new task → "explorer.exe"** লিখে OK দিন
5. **এরপর build করুন**:
   ```bash
   npm run build:win
   ```

#### সমাধান ৪: Antivirus Temporarily Disable করুন

1. **Windows Security খুলুন**
2. **Virus & threat protection** → **Manage settings**
3. **Real-time protection OFF** করুন (temporarily)
4. **Build করুন**:
   ```bash
   npm run build:win
   ```
5. **Build শেষে Real-time protection আবার ON করুন**

#### সমাধান ৫: Folder থেকে Build করুন (ভিন্ন location)

```bash
# 1. Project folder copy করুন
# From: E:\Backup 1\Codes\...
# To: C:\Projects\nex-credentials-manager

# 2. নতুন location থেকে build করুন
cd C:\Projects\nex-credentials-manager
npm install
npm run build:win
```

#### সমাধান ৬: Safe Mode এ Boot করুন (Last resort)

1. Restart computer
2. Boot করার সময় F8 চাপুন
3. Safe Mode select করুন
4. Build করুন
5. Normal mode এ restart করুন

---

## সমস্যা ৪: npm install এ warnings

### এগুলো ignore করা যায়:
- `deprecated` warnings সাধারণ - app চলবে
- শুধু security vulnerabilities check করুন:
  ```bash
  npm audit
  ```

### যদি fix করতে চান:
```bash
npm audit fix
```

---

## সমস্যা ৪: Port Already in Use

### সমাধান:
```bash
# সব Electron process kill করুন
taskkill /F /IM electron.exe

# এরপর আবার চালান
npm start
```

---

## সম্পূর্ণ Clean Install

যদি সব কিছু ঠিক না হয়:

```bash
# 1. Dependencies ডিলিট করুন
rmdir /s node_modules
del package-lock.json

# 2. User data ডিলিট করুন (optional - সব ডেটা মুছে যাবে!)
rmdir /s %APPDATA%\nex-credentials-manager

# 3. আবার install করুন
npm install

# 4. চালান
npm start
```

---

## Build Output Location

Build সফল হলে এখানে পাবেন:
```
dist/
├── nex-credentials-manager Setup 1.0.0.exe  (Installer)
└── win-unpacked/                             (Unpacked app)
```

---

## দ্রুত চেকলিস্ট

### npm start চলছে না?
- [ ] Node.js installed? (`node --version`)
- [ ] Dependencies installed? (`npm install`)
- [ ] Config file corrupt? (Delete `%APPDATA%\nex-credentials-manager\config.json`)
- [ ] Port busy? (`taskkill /F /IM electron.exe`)

### npm run build:win চলছে না?
- [ ] Run as Administrator?
- [ ] Developer Mode enabled?
- [ ] Clear cache? (`rmdir /s %LOCALAPPDATA%\electron-builder\Cache`)
- [ ] Internet connection? (Downloads dependencies)

---

## পরীক্ষামূলক চালানো (Build ছাড়া)

যদি শুধু test করতে চান build না করে:

```bash
# Normal way
npm start

# বা Electron directly
npx electron .
```

---

## সাধারণ Commands

```bash
# Install dependencies
npm install

# Run app
npm start

# Build for Windows
npm run build:win

# Clear cache
npm cache clean --force

# Check for issues
npm audit

# Update packages
npm update
```

---

## যোগাযোগ

সমস্যা থাকলে:
1. Error message এর screenshot নিন
2. Console output copy করুন
3. Node.js version check করুন (`node --version`)
4. Windows version check করুন (`winver`)

---

## আপডেট করা ফাইল

নতুন version এ এই সমস্যাগুলো fix করা হয়েছে:
- ✅ Config loading error handling
- ✅ Build configuration optimized
- ✅ Empty file handling

শুধু নতুন ZIP file download করে আবার extract করুন!
