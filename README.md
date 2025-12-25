# Nex Credentials Manager

A secure, offline desktop credentials manager built with Electron JS featuring AES-256 encryption and comprehensive security features.

## 🔐 Features

### Security
- **AES-256 Encryption**: All credentials encrypted locally
- **Master PIN Protection**: Secure access with bcrypt-hashed PIN
- **Auto-lock**: Locks after 5 minutes of inactivity
- **System Lock Integration**: Automatically locks when OS screen locks
- **Wrong Attempt Protection**: Locks for 30 seconds after 5 failed attempts
- **Clipboard Auto-clear**: Automatically clears copied passwords after 30 seconds
- **View Protection**: Blurs sensitive data when app loses focus

### Productivity
- **Smart Search**: Real-time filtering by title, username, or URL
- **Keyboard Shortcuts**: 
  - `Ctrl+K`: Quick search
  - `Ctrl+Shift+N`: Add new credential
- **Categories**: Organize credentials (Social, Work, Banking, Personal)
- **Password Intelligence**: Detects weak and reused passwords
- **Recent Items**: Quick access to recently used credentials
- **Auto-icon System**: Displays service-specific icons

### Password Management
- **Password Generator**: Creates strong, random passwords
- **Strength Indicator**: Real-time password strength analysis
- **Reuse Detection**: Warns when passwords are reused
- **Backup Codes**: Store 2FA backup codes securely

### Import/Export
- **Encrypted Backups**: Create and restore encrypted vault backups
- **Auto Backup**: Optional scheduled backups (daily/weekly)
- **Conflict Resolution**: Smart merge when importing

### Customization
- **Multiple Themes**: Light, Dark, NexDark, Blue Gradient, System
- **Tray Mode**: Minimize to system tray
- **Frameless Window**: Modern desktop appearance

## 📦 Installation

### Prerequisites
- Node.js 18 or higher
- npm or yarn

### Setup

1. Clone or extract the project:
```bash
cd nex-credentials-manager
```

2. Install dependencies:
```bash
npm install
```

3. Run the application:
```bash
npm start
```

## 🏗️ Building

### Build for All Platforms
```bash
npm run build
```

### Build for Specific Platforms
```bash
npm run build:win    # Windows (.exe)
npm run build:mac    # macOS (.dmg)
npm run build:linux  # Linux (.AppImage)
```

Built applications will be in the `dist/` folder.

## 📖 Usage

### First Launch
1. Set your Master PIN (minimum 6 characters, strong PIN recommended)
2. Start adding credentials

### Adding Credentials
1. Click the **+** button or press `Ctrl+Shift+N`
2. Fill in:
   - Title (required)
   - URL (optional)
   - Username/Email (required)
   - Password (required) - use generator for strong passwords
   - Backup Codes (optional)
   - Category
   - Notes (optional)
3. Click **Save Credential**

### Managing Credentials
- **View**: Click on a credential card
- **Edit**: Click the edit icon on a card
- **Delete**: Click the delete icon (confirms before deletion)
- **Copy Password**: Click the copy icon in edit mode

### Security Features
- **Lock Vault**: Click the lock icon in sidebar or wait 5 minutes
- **Change PIN**: Settings → Change Master PIN
- **Check Security**: View weak and reused passwords from sidebar

### Backup & Restore
- **Create Backup**: Settings → Create Backup Now
- **Auto Backup**: Enable in Settings for scheduled backups
- **Restore**: Use Import feature (backups are in AppData/backups)

## 🔒 Security Details

### Encryption
- Algorithm: AES-256-CBC
- Key Derivation: scrypt with salt
- PIN Hashing: bcrypt with 10 rounds

### Data Storage
- Vault: `%APPDATA%/nex-credentials-manager/vault.enc` (encrypted)
- Config: `%APPDATA%/nex-credentials-manager/config.json` (PIN hash only)
- Backups: `%APPDATA%/nex-credentials-manager/backups/` (encrypted)

### Privacy
- **100% Offline**: No internet connection required or used
- **No Telemetry**: No data sent anywhere
- **Local Only**: All data stays on your device

## ⚠️ Important Notes

1. **Remember Your PIN**: The Master PIN cannot be recovered if lost
2. **Backup Regularly**: Create backups before changing PIN or reinstalling
3. **Strong PIN**: Use a strong, unique PIN with letters, numbers, and symbols
4. **Keep Backups Safe**: Backup files are encrypted but still sensitive

## 🛠️ Development

### Project Structure
```
nex-credentials-manager/
├── src/
│   ├── main/
│   │   ├── main.js      # Main Electron process
│   │   └── preload.js   # Preload script
│   ├── renderer/
│   │   ├── splash.html  # Splash screen
│   │   ├── setup.html   # First-time setup
│   │   ├── security.html # Login screen
│   │   └── home.html    # Main interface
│   └── assets/
│       └── icons/       # App icons
├── styles/
│   ├── common.css       # Shared styles
│   ├── security.css     # Login/setup styles
│   └── home.css         # Main interface styles
├── scripts/
│   ├── setup.js         # Setup logic
│   ├── security.js      # Login logic
│   └── home.js          # Main app logic
└── package.json
```

### Technologies
- **Framework**: Electron 28
- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Backend**: Node.js
- **Encryption**: Node.js crypto module
- **Password Hashing**: bcrypt

## 📝 License

MIT License - See LICENSE file for details

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 🐛 Bug Reports

Found a bug? Please open an issue with:
- Description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots (if applicable)

## 💡 Feature Requests

Have an idea? Open an issue with:
- Feature description
- Use case
- Expected behavior

## 📧 Support

For support, please open an issue on GitHub.

---

**Made with 🔐 by NexApp**

**Remember**: Never share your Master PIN with anyone!
