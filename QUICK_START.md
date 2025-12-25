# Quick Start Guide - Nex Credentials Manager

## 🚀 Getting Started in 3 Minutes

### Step 1: Install Dependencies (First Time Only)

Open your terminal/command prompt in the project folder and run:

```bash
npm install
```

This will install all required packages. This only needs to be done once.

### Step 2: Run the Application

```bash
npm start
```

The app will launch with a splash screen, then prompt you to create your Master PIN.

### Step 3: Create Your Master PIN

1. Enter a strong PIN (minimum 6 characters)
   - **Tip**: Use a mix of letters, numbers, and symbols
   - **Example**: `MySecure2024!`
2. Confirm your PIN
3. Click "Create Master PIN"

⚠️ **Important**: Remember this PIN! It cannot be recovered.

### Step 4: Add Your First Credential

1. Click the **+** button at the top of the sidebar
2. Fill in the details:
   - **Title**: e.g., "Gmail Account"
   - **Username**: your email
   - **Password**: Use the 🔄 generator button for a strong password
   - **Category**: Choose from Social, Work, Banking, Personal
3. Click "Save Credential"

## 🎯 Essential Features

### Quick Actions
- **Add New**: Click `+` button or press `Ctrl+Shift+N`
- **Search**: Click search box or press `Ctrl+K`
- **Lock App**: Click the 🔒 icon in sidebar

### Copy Passwords Safely
1. Click on a credential to edit
2. Click the 📋 copy icon next to password
3. Password auto-clears from clipboard after 30 seconds

### Check Password Security
- **Weak Passwords**: Click "Weak Passwords" in sidebar
- **Reused Passwords**: Click "Reused Passwords" in sidebar
- Yellow/Red indicators show weak passwords

### Change Your Master PIN
1. Click ⚙️ Settings
2. Click "Change Master PIN"
3. Enter old PIN, then new PIN twice
4. Vault is automatically re-encrypted

## 💾 Backup Your Vault

### Manual Backup
1. Click ⚙️ Settings
2. Click "Create Backup Now"
3. Backup saved to: `%APPDATA%/nex-credentials-manager/backups/`

### Auto Backup
1. Click ⚙️ Settings
2. Check "Enable automatic backups"
3. Choose frequency (Daily/Weekly)

## 🎨 Customize Appearance

1. Click ⚙️ Settings
2. Select Theme:
   - **System**: Follows your OS theme
   - **Light**: Classic light theme
   - **Dark**: Dark mode
   - **NexDark**: Black with neon accents
   - **Blue Gradient**: Purple-blue gradient

## 🔐 Security Features Explained

### Auto-Lock
- App locks after 5 minutes of no activity
- Protects your data if you step away

### Wrong Attempts Protection
- After 5 wrong PIN attempts, app locks for 30 seconds
- Prevents brute-force attacks

### System Lock Integration
- When you lock your computer (Windows+L), app locks too
- Ensures security even if you forget to lock

### View Protection
- Password fields blur when app loses focus
- Prevents shoulder-surfing

## 📦 Building Standalone App

Want to create an executable file?

### For Windows:
```bash
npm run build:win
```
Creates `.exe` installer in `dist/` folder

### For Mac:
```bash
npm run build:mac
```
Creates `.dmg` installer in `dist/` folder

### For Linux:
```bash
npm run build:linux
```
Creates `.AppImage` in `dist/` folder

## ⚡ Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+N` | Add new credential |
| `Ctrl+K` | Focus search box |
| `Enter` | Submit forms |

## ❓ Common Questions

### Q: I forgot my Master PIN. What do I do?
**A**: Unfortunately, the PIN cannot be recovered. This is by design for security. You'll need to delete the vault file and start fresh.

### Q: Where is my data stored?
**A**: All data is stored locally at:
- Windows: `C:\Users\YourName\AppData\Roaming\nex-credentials-manager\`
- Mac: `~/Library/Application Support/nex-credentials-manager/`
- Linux: `~/.config/nex-credentials-manager/`

### Q: Can I sync across devices?
**A**: No, the app is designed to be offline-only for maximum security. However, you can:
1. Create a backup on one device
2. Copy the `.vault` backup file to another device
3. Import it (future feature)

### Q: Is my data safe?
**A**: Yes! The app uses:
- AES-256 encryption (military-grade)
- Offline operation (no internet connection)
- Local storage only (never uploaded)
- Bcrypt PIN hashing (cannot be reversed)

### Q: How do I uninstall?
**A**: 
1. Delete the app folder
2. Delete data folder (see "Where is my data stored?" above)
3. That's it!

## 🆘 Need Help?

1. Check the full README.md for detailed documentation
2. Open an issue on GitHub
3. Review the code - it's open source!

## 🎉 You're All Set!

You now have a secure, professional password manager running on your computer. Remember:
- Use strong, unique passwords for each service
- Enable auto-backup
- Keep your Master PIN secret and memorable
- Lock the app when stepping away

**Happy password managing! 🔐**

---

*Made with 💙 by NexApp*
