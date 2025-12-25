# Development Guide - Nex Credentials Manager

## 🏗️ Architecture Overview

### Application Structure

```
Electron App (Main Process)
    ↓
    ├─→ Window Management (BrowserWindow)
    ├─→ Security Manager (Encryption, PIN verification)
    ├─→ IPC Handlers (Communication with Renderer)
    └─→ File System Operations (Vault, Config, Backups)
    
Renderer Process
    ↓
    ├─→ UI Components (HTML/CSS)
    ├─→ User Interactions (JavaScript)
    ├─→ IPC Client (Communication with Main)
    └─→ State Management (In-memory vault data)
```

### Security Model

1. **Master PIN** → bcrypt hash → stored in config.json
2. **Credentials** → JSON → AES-256 encryption → vault.enc file
3. **In-Memory** → Decrypted vault data (during session only)
4. **Session** → Master PIN stored in sessionStorage (cleared on lock)

## 📁 File Structure Explained

### Main Process (`src/main/`)

#### `main.js`
- **Purpose**: Main Electron process, application lifecycle
- **Responsibilities**:
  - Window creation and management
  - IPC handler registration
  - Security enforcement (auto-lock, wrong attempts)
  - File system operations
  - Global shortcuts
  - System integration (tray, power monitor)

Key classes:
- `VaultManager`: Encryption/decryption using AES-256-CBC
- `ConfigManager`: Configuration persistence

#### `preload.js`
- **Purpose**: Secure bridge between main and renderer processes
- **Why**: Enables contextIsolation for security
- **Exposes**: Safe API methods to renderer via `contextBridge`

### Renderer Process (`src/renderer/`)

#### HTML Files
- `splash.html`: Animated loading screen (3-second timeout)
- `setup.html`: First-time Master PIN setup
- `security.html`: Login/unlock screen
- `home.html`: Main application interface

#### JavaScript Files (`scripts/`)

**`setup.js`**
- PIN strength validation
- First-time setup flow
- PIN confirmation matching

**`security.js`**
- PIN verification
- Wrong attempt handling
- Session initialization

**`home.js`**
- Main application logic
- Credential CRUD operations
- Search and filtering
- Category management
- Password strength analysis
- Reused password detection
- Modal management
- Theme switching
- Settings management
- Import/Export (limited)
- Inactivity tracking
- Keyboard shortcuts

#### CSS Files (`styles/`)

**`common.css`**
- Base styles and CSS variables
- Theme definitions (light, dark, nex-dark, blue-gradient)
- Titlebar styling
- Button styles
- Form elements
- Modal components

**`security.css`**
- Login/setup screen specific styles
- Animated background
- PIN input styling

**`home.css`**
- Main interface layout (sidebar + content)
- Credential card styling
- Modal layouts
- Responsive design

## 🔐 Security Implementation Details

### Encryption (AES-256-CBC)

```javascript
// Encryption process:
1. Generate random 16-byte IV (Initialization Vector)
2. Derive 32-byte key from Master PIN using scrypt
3. Encrypt JSON data using AES-256-CBC
4. Store as: IV:ENCRYPTED_DATA

// Decryption process:
1. Split stored data into IV and encrypted parts
2. Derive key from Master PIN
3. Decrypt using IV and key
4. Parse JSON
```

### PIN Hashing (bcrypt)

```javascript
// Setup:
PIN → bcrypt.hash(pin, 10) → store hash

// Verification:
PIN → bcrypt.compare(pin, hash) → boolean
```

### Session Management

```javascript
// On unlock:
sessionStorage.setItem('masterPin', pin)

// On lock:
sessionStorage.removeItem('masterPin')
window.location.href = 'security.html'

// On app start:
if (!sessionStorage.getItem('masterPin')) {
  redirect to security.html
}
```

### Inactivity Timer

```javascript
// Track user activity
document.addEventListener('mousemove', resetTimer)
document.addEventListener('keydown', resetTimer)

// After 5 minutes → lock app
setTimeout(() => lockApp(), 5 * 60 * 1000)
```

## 🛠️ Development Setup

### Prerequisites
```bash
node --version  # v18+ required
npm --version   # v8+ required
```

### First Time Setup
```bash
# Clone/extract project
cd nex-credentials-manager

# Install dependencies
npm install

# Run in development mode
npm start
```

### Development Tools

**Enable DevTools** (for debugging):
```javascript
// In src/main/main.js, add after window creation:
mainWindow.webContents.openDevTools();
```

**Hot Reload** (manual):
- Save file changes
- Restart app with `npm start`

**Debugging**:
- Main Process: Use console.log → appears in terminal
- Renderer Process: Use console.log → appears in DevTools

## 🧪 Testing Checklist

### Security Tests
- [ ] Wrong PIN attempt counter works
- [ ] 30-second lockout after 5 attempts
- [ ] Auto-lock after 5 minutes
- [ ] Lock on system lock (Windows+L)
- [ ] Clipboard clears after 30 seconds
- [ ] View blur on window focus loss
- [ ] Encryption/decryption works correctly
- [ ] PIN change re-encrypts vault

### Functionality Tests
- [ ] Add credential
- [ ] Edit credential
- [ ] Delete credential (with confirmation)
- [ ] Search filters correctly
- [ ] Category filtering works
- [ ] Recent items tracking
- [ ] Weak password detection
- [ ] Reused password detection
- [ ] Password generator creates strong passwords
- [ ] Password strength indicator accurate
- [ ] Theme switching works
- [ ] Settings persist
- [ ] Backup creation works
- [ ] Master PIN change works

### UI Tests
- [ ] Responsive layout
- [ ] All modals open/close
- [ ] Keyboard shortcuts work
- [ ] Forms validate correctly
- [ ] Error messages display
- [ ] Icons display correctly
- [ ] Animations smooth

## 🚀 Build Process

### Development Build
```bash
npm start  # Runs electron directly
```

### Production Build
```bash
# Build for current platform
npm run build

# Platform-specific
npm run build:win    # Windows
npm run build:mac    # macOS
npm run build:linux  # Linux
```

### Build Configuration

Located in `package.json` under `"build"`:

```json
{
  "build": {
    "appId": "com.nexapp.credentials",
    "productName": "Nex Credentials Manager",
    "files": ["src/**/*", "styles/**/*", "scripts/**/*"],
    "win": { "target": "nsis" },
    "mac": { "target": "dmg" },
    "linux": { "target": "AppImage" }
  }
}
```

## 📝 Coding Standards

### JavaScript Style
```javascript
// Use camelCase for variables and functions
let userName = 'John';
function getUserData() { }

// Use PascalCase for classes
class VaultManager { }

// Use UPPER_CASE for constants
const MAX_ATTEMPTS = 5;

// Use async/await over promises
async function saveData() {
  await window.electronAPI.saveVaultData(pin, data);
}

// Always handle errors
try {
  await riskyOperation();
} catch (error) {
  console.error('Operation failed:', error);
}
```

### HTML/CSS
- Use semantic HTML5 elements
- BEM-like class naming: `.credential-card`, `.credential-header`
- CSS variables for theming: `var(--accent-color)`
- Mobile-first responsive design

### Security Best Practices
- Never log sensitive data (PINs, passwords)
- Always use IPC for main-renderer communication
- Never expose Node.js modules directly to renderer
- Validate all user inputs
- Use parameterized operations (avoid injection)

## 🐛 Common Issues & Solutions

### Issue: App won't start
**Solution**: Delete `node_modules` and reinstall:
```bash
rm -rf node_modules
npm install
```

### Issue: Build fails
**Solution**: 
1. Check Node.js version (18+)
2. Clear cache: `npm cache clean --force`
3. Reinstall dependencies

### Issue: Vault data lost
**Solution**: 
- Check AppData folder for vault.enc file
- Restore from backup if available
- Vault location: `%APPDATA%/nex-credentials-manager/`

### Issue: PIN not working
**Solution**:
- Wrong PIN: Check caps lock, try again
- If truly forgotten: Delete vault.enc and config.json (data will be lost)

### Issue: DevTools not opening
**Solution**: Add to main.js:
```javascript
mainWindow.webContents.openDevTools();
```

## 🔄 Adding New Features

### Example: Adding a New Category

1. **Update Vault Structure** (main.js):
```javascript
const defaultCategories = ['Social', 'Work', 'Banking', 'Personal', 'NewCategory'];
```

2. **Add UI Element** (home.html):
```html
<button class="nav-item" data-category="NewCategory">
  <span class="nav-icon">🎯</span>
  <span>New Category</span>
  <span class="nav-count" id="count-newcategory">0</span>
</button>
```

3. **Add Counter Update** (home.js):
```javascript
document.getElementById('count-newcategory').textContent = 
  vaultData.credentials.filter(c => c.category === 'NewCategory').length;
```

4. **Add to Dropdown** (home.html):
```html
<option value="NewCategory">New Category</option>
```

## 📚 Useful Resources

- [Electron Documentation](https://www.electronjs.org/docs)
- [Node.js Crypto](https://nodejs.org/api/crypto.html)
- [bcrypt Documentation](https://github.com/kelektiv/node.bcrypt.js)
- [IPC Communication](https://www.electronjs.org/docs/latest/tutorial/ipc)
- [Security Best Practices](https://www.electronjs.org/docs/latest/tutorial/security)

## 🤝 Contributing Guidelines

1. Fork the repository
2. Create feature branch: `git checkout -b feature-name`
3. Test thoroughly (security + functionality)
4. Update documentation if needed
5. Commit with clear messages: `git commit -m "Add feature: description"`
6. Push and create pull request

### Commit Message Format
```
<type>: <description>

feat: Add backup encryption
fix: Resolve auto-lock timer issue
docs: Update security documentation
style: Improve modal animations
refactor: Simplify password strength checker
test: Add PIN verification tests
```

## 📊 Performance Optimization

- Debounce search input (300ms)
- Use virtual scrolling for 1000+ credentials
- Lazy load credential icons
- Minimize re-renders in home.js
- Cache frequently accessed data

## 🔮 Future Enhancement Ideas

- [ ] Biometric unlock (Windows Hello, Touch ID)
- [ ] Browser extension integration
- [ ] Cloud sync (optional, encrypted)
- [ ] Password history
- [ ] Secure notes
- [ ] File attachments
- [ ] Two-factor authentication support
- [ ] Import from other password managers
- [ ] Password expiration reminders
- [ ] Breach monitoring

---

**Happy Coding! 🚀**

Questions? Open an issue or check the README.md!
