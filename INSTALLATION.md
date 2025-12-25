# Installation Guide - Nex Credentials Manager

Complete step-by-step guide to get Nex Credentials Manager running on your system.

## 📋 System Requirements

### Minimum Requirements
- **Operating System**: Windows 10+, macOS 10.13+, or Linux (Ubuntu 18.04+)
- **RAM**: 2 GB
- **Disk Space**: 200 MB
- **Node.js**: Version 18.0.0 or higher
- **npm**: Version 8.0.0 or higher

### Recommended
- **Operating System**: Windows 11, macOS 13+, or Ubuntu 22.04+
- **RAM**: 4 GB or more
- **Disk Space**: 500 MB (for development dependencies)

## 🔧 Prerequisites Installation

### Windows

1. **Install Node.js**:
   - Download from: https://nodejs.org/
   - Choose "LTS" (Long Term Support) version
   - Run the installer (`.msi` file)
   - Follow installation wizard (use default settings)
   - Verify installation:
     ```bash
     node --version
     npm --version
     ```

2. **Optional: Install Git** (for cloning):
   - Download from: https://git-scm.com/
   - Run installer with default options

### macOS

1. **Install Homebrew** (if not installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Node.js**:
   ```bash
   brew install node
   ```

3. **Verify installation**:
   ```bash
   node --version
   npm --version
   ```

### Linux (Ubuntu/Debian)

1. **Install Node.js**:
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

2. **Verify installation**:
   ```bash
   node --version
   npm --version
   ```

## 📦 Application Installation

### Method 1: Running from Source (Recommended for Development)

1. **Download/Extract the Project**:
   - If you have a ZIP file, extract it to a location like:
     - Windows: `C:\Projects\nex-credentials-manager`
     - macOS/Linux: `~/Projects/nex-credentials-manager`

2. **Open Terminal/Command Prompt**:
   - Windows: Press `Win + R`, type `cmd`, press Enter
   - macOS: Press `Cmd + Space`, type "Terminal", press Enter
   - Linux: Press `Ctrl + Alt + T`

3. **Navigate to Project Folder**:
   ```bash
   cd path/to/nex-credentials-manager
   ```
   Example:
   ```bash
   # Windows
   cd C:\Projects\nex-credentials-manager
   
   # macOS/Linux
   cd ~/Projects/nex-credentials-manager
   ```

4. **Install Dependencies**:
   ```bash
   npm install
   ```
   This will take 2-5 minutes depending on your internet speed.

5. **Add Application Icon** (Optional):
   - Place a 512x512 PNG file named `icon.png` in `src/assets/`
   - See `src/assets/ICON_INFO.txt` for details
   - Skip this step to use default icon

6. **Run the Application**:
   ```bash
   npm start
   ```

### Method 2: Building Standalone Executable

Build a standalone app that doesn't require Node.js to run:

#### For Windows (.exe)
```bash
npm install
npm run build:win
```
- Output location: `dist/nex-credentials-manager Setup 1.0.0.exe`
- Double-click to install
- App installs to: `C:\Program Files\Nex Credentials Manager`

#### For macOS (.dmg)
```bash
npm install
npm run build:mac
```
- Output location: `dist/nex-credentials-manager-1.0.0.dmg`
- Open DMG and drag app to Applications folder
- App location: `/Applications/Nex Credentials Manager.app`

#### For Linux (.AppImage)
```bash
npm install
npm run build:linux
```
- Output location: `dist/nex-credentials-manager-1.0.0.AppImage`
- Make executable: `chmod +x nex-credentials-manager-1.0.0.AppImage`
- Run: `./nex-credentials-manager-1.0.0.AppImage`

## 🚀 First Launch

1. **Start the Application**:
   - From source: `npm start`
   - From build: Double-click the installed app

2. **Splash Screen**:
   - Wait 3 seconds for animated splash screen

3. **Create Master PIN**:
   - Enter a strong PIN (minimum 6 characters)
   - Use mix of uppercase, lowercase, numbers, symbols
   - Confirm PIN by entering again
   - Click "Create Master PIN"

4. **Main Screen**:
   - You'll see the main interface with empty vault
   - Click the `+` button to add your first credential

## 🛠️ Troubleshooting Installation Issues

### Issue: "node: command not found"
**Solution**: 
- Node.js not installed or not in PATH
- Restart terminal after installing Node.js
- Windows: Restart computer after Node.js installation

### Issue: "npm ERR! code EACCES" (macOS/Linux)
**Solution**:
```bash
sudo chown -R $USER:$USER ~/.npm
sudo chown -R $USER:$USER ./
```

### Issue: "Cannot find module" errors
**Solution**:
```bash
rm -rf node_modules package-lock.json
npm install
```

### Issue: "EPERM: operation not permitted" (Windows)
**Solution**:
- Run Command Prompt as Administrator
- Or temporarily disable antivirus
- Or add project folder to antivirus exclusions

### Issue: Build fails with "electron-builder" error
**Solution**:
```bash
npm install electron-builder --save-dev
npm run build
```

### Issue: App won't start - "App is already running"
**Solution**:
- Task Manager (Windows) or Activity Monitor (Mac)
- Kill any "Electron" or "Nex Credentials" processes
- Try starting again

### Issue: "Python not found" during npm install (Windows)
**Solution**:
```bash
npm install --global windows-build-tools
```
Or install Python 3 from python.org

## 📍 File Locations

### Application Data
All user data is stored locally:

**Windows**:
```
C:\Users\YourName\AppData\Roaming\nex-credentials-manager\
├── vault.enc         (encrypted credentials)
├── config.json       (settings and PIN hash)
└── backups\          (backup files)
```

**macOS**:
```
~/Library/Application Support/nex-credentials-manager/
├── vault.enc
├── config.json
└── backups/
```

**Linux**:
```
~/.config/nex-credentials-manager/
├── vault.enc
├── config.json
└── backups/
```

### Project Files (Development)
```
nex-credentials-manager/
├── src/              (source code)
├── styles/           (CSS files)
├── scripts/          (JavaScript files)
├── node_modules/     (dependencies)
├── dist/             (built applications)
└── package.json      (project configuration)
```

## 🔄 Updating the Application

### From Source
```bash
cd nex-credentials-manager
git pull              # If using git
npm install           # Install any new dependencies
npm start             # Run updated version
```

### Built Version
- Download new version
- Install over old version (Windows/Mac)
- Or replace AppImage file (Linux)
- Your data is preserved (separate from app files)

## 🗑️ Uninstallation

### Remove Application

**Windows**:
- Settings → Apps → Nex Credentials Manager → Uninstall
- Or delete project folder if running from source

**macOS**:
- Drag app from Applications to Trash
- Or delete project folder if running from source

**Linux**:
- Delete AppImage file
- Or delete project folder if running from source

### Remove User Data (Optional)

⚠️ **Warning**: This deletes all your credentials!

**Windows**:
```bash
rmdir /s "%APPDATA%\nex-credentials-manager"
```

**macOS**:
```bash
rm -rf ~/Library/Application\ Support/nex-credentials-manager
```

**Linux**:
```bash
rm -rf ~/.config/nex-credentials-manager
```

## 📱 Setting Up System Startup (Optional)

### Windows
1. Press `Win + R`, type `shell:startup`, press Enter
2. Create shortcut to application in this folder
3. App starts automatically on login

### macOS
1. System Settings → General → Login Items
2. Click `+` and add Nex Credentials Manager
3. App starts automatically on login

### Linux (Ubuntu)
1. Open "Startup Applications"
2. Click "Add"
3. Command: `/path/to/nex-credentials-manager.AppImage`
4. Save

## 🔐 Security Notes

- The application is **100% offline** - it never connects to the internet
- All data is stored **locally only** on your device
- Vault file is **encrypted with AES-256**
- Master PIN is **hashed with bcrypt** (cannot be reversed)
- **Backup your vault regularly** to prevent data loss

## ✅ Verify Installation

Run these checks to ensure everything works:

1. **Launch app** - Should show splash screen then setup/login
2. **Create PIN** - Should accept and save PIN
3. **Add credential** - Should save and display credential
4. **Lock/Unlock** - Should lock and unlock with correct PIN
5. **Search** - Should filter credentials in real-time
6. **Theme switch** - Should change appearance
7. **Backup** - Should create .vault file in backups folder

## 📞 Getting Help

If you encounter issues:

1. Check [QUICK_START.md](QUICK_START.md) for common questions
2. Review [README.md](README.md) for feature documentation
3. Check [DEVELOPMENT.md](DEVELOPMENT.md) for technical details
4. Open an issue on GitHub with:
   - Your operating system and version
   - Node.js version (`node --version`)
   - Error messages (full text)
   - Steps to reproduce the issue

## 🎉 You're Ready!

Installation complete! Your secure password manager is ready to use.

**Next Steps**:
1. Read [QUICK_START.md](QUICK_START.md) for usage guide
2. Create your first credential
3. Set up automatic backups
4. Customize your theme

---

**Enjoy secure password management! 🔐**

*Made with 💙 by NexApp*
