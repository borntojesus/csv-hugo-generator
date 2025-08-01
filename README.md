# ScrapingBee Hugo Site

Automated landing page generation for scraper tools from CSV file.

## 🌍 Supported Platforms

- ✅ **Windows** (PowerShell, Command Prompt, Git Bash, WSL)
- ✅ **Linux** (Ubuntu, CentOS, Debian, etc.)
- ✅ **macOS** (Terminal, Homebrew)
- ✅ **WSL** (Windows Subsystem for Linux)

## Project Structure

```
scrapingbee-hugo/
├── content/
│   ├── _index.md          # Homepage content
│   └── scrapers/          # Generated scraper pages
├── layouts/
│   ├── _default/
│   │   └── baseof.html    # Base layout template
│   ├── scrapers/
│   │   ├── single.html    # Individual scraper page layout
│   │   └── list.html      # Scraper list layout
│   └── index.html         # Homepage layout (Hero + Scrapers list)
├── static/
│   ├── css/
│   │   └── main.css       # Styles (simplified)
│   └── js/
│       └── main.js        # JavaScript
├── config.toml            # Hugo configuration
├── start.ps1              # PowerShell script for Windows
├── start.bat              # Batch script for Windows
├── generate-content.ps1   # PowerShell script for content generation
└── README.md              # This file
```

## 🚀 Quick Start

### Windows

**Option 1: PowerShell (Recommended)**
```powershell
# Run the complete setup
powershell -ExecutionPolicy Bypass -File start.ps1
```

**Option 2: Command Prompt**
```cmd
# Run the batch file
start.bat
```

**Option 3: Manual Steps**
```powershell
# Step 1: Generate content from CSV
powershell -ExecutionPolicy Bypass -File generate-content.ps1

# Step 2: Start Hugo server
hugo server --bind 0.0.0.0 --port 1313
```

### Linux (Ubuntu/Debian)

**Step 1: Install Hugo**
```bash
# Update package list
sudo apt update

# Install Hugo
sudo apt install hugo

# Verify installation
hugo version
```

**Step 2: Generate Content**
```bash
# Make PowerShell script executable (if using WSL)
chmod +x generate-content.ps1

# Generate content from CSV
powershell -ExecutionPolicy Bypass -File generate-content.ps1
```

**Step 3: Start Server**
```bash
# Start Hugo development server
hugo server --bind 0.0.0.0 --port 1313
```

### Linux (CentOS/RHEL)

**Step 1: Install Hugo**
```bash
# Install EPEL repository
sudo yum install epel-release

# Install Hugo
sudo yum install hugo

# Verify installation
hugo version
```

**Step 2: Generate and Run**
```bash
# Generate content
powershell -ExecutionPolicy Bypass -File generate-content.ps1

# Start server
hugo server --bind 0.0.0.0 --port 1313
```

### macOS

**Step 1: Install Hugo**
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Hugo
brew install hugo

# Verify installation
hugo version
```

**Step 2: Generate and Run**
```bash
# Generate content
powershell -ExecutionPolicy Bypass -File generate-content.ps1

# Start server
hugo server --bind 0.0.0.0 --port 1313
```

### WSL (Windows Subsystem for Linux)

**Step 1: Install Hugo in WSL**
```bash
# Update package list
sudo apt update

# Install Hugo
sudo apt install hugo

# Verify installation
hugo version
```

**Step 2: Generate and Run**
```bash
# Navigate to project directory
cd /mnt/e/scrapingbee-hugo

# Generate content
powershell -ExecutionPolicy Bypass -File generate-content.ps1

# Start server
hugo server --bind 0.0.0.0 --port 1313
```

## 📊 Individual Commands

### Content Generation

**Generate content from CSV:**
```powershell
powershell -ExecutionPolicy Bypass -File generate-content.ps1
```

**Generate content manually:**
```bash
# Create content directory
mkdir -p content/scrapers

# Run Hugo server
hugo server --bind 0.0.0.0 --port 1313
```

### Hugo Server

**Start development server:**
```bash
hugo server --bind 0.0.0.0 --port 1313
```

**Start with drafts:**
```bash
hugo server -D --bind 0.0.0.0 --port 1313
```

**Start with live reload:**
```bash
hugo server --bind 0.0.0.0 --port 1313 --disableFastRender
```

### Production Build

**Build for production:**
```bash
hugo --minify
```

**Build with specific environment:**
```bash
hugo --environment production --minify
```

## 📦 Hugo Installation

### Windows

1. **Download Hugo:**
   - Go to https://gohugo.io/installation/
   - Download the latest Windows version
   - Extract to `C:\Hugo\bin`
   - Add `C:\Hugo\bin` to your PATH environment variable

2. **Verify installation:**
   ```cmd
   hugo version
   ```

### Ubuntu/Debian

```bash
# Update package list
sudo apt update

# Install Hugo
sudo apt install hugo

# Verify installation
hugo version
```

### CentOS/RHEL

```bash
# Install EPEL repository
sudo yum install epel-release

# Install Hugo
sudo yum install hugo

# Verify installation
hugo version
```

### macOS

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Hugo
brew install hugo

# Verify installation
hugo version
```

## How It Works

1. **CSV Files** contain data for all scraper pages (supports multiple CSV files)
2. **PowerShell Script** reads all CSV files and generates Hugo content files
3. **Smart Generation** - only creates new files, skips existing ones
4. **Hugo Layouts** display data from content files
5. **Automatic Updates** when CSV files change

## CSV File Structure

**Multiple CSV files are supported!** The script will process all `.csv` files in the project directory.

Each CSV file should contain the following columns:
- `Scraper name` - scraper name
- `Meta title` - page title
- `Meta description` - page description
- `HERO` columns - content for hero section

**Smart Generation:**
- Only generates new files
- Skips existing files to avoid overwriting
- Processes all CSV files in the directory

## Configuration

Edit `config.toml` to change:
- Site name
- URL
- Menu
- Parameters

## Adding New Scrapers

**Option 1: Add to existing CSV file**
1. Add a new row to any CSV file
2. Run the generation script
3. Hugo automatically creates a new page

**Option 2: Create new CSV file**
1. Create a new `.csv` file in the project directory
2. Follow the CSV structure format
3. Run the generation script
4. All new scrapers will be generated automatically

**Smart Features:**
- Only generates new files (skips existing ones)
- Processes all CSV files in the directory
- Maintains existing content

## Troubleshooting

### Common Issues

**PowerShell Execution Policy Error:**
```powershell
# Run as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Hugo Not Found:**
```bash
# Check if Hugo is installed
hugo version

# If not found, install Hugo (see installation section)
```

**Port Already in Use:**
```bash
# Use different port
hugo server --bind 0.0.0.0 --port 1314
```

**CSV File Not Found:**
```bash
# Check if CSV file exists
ls "Copy of Alpina _ SBee - Example - Horizontal Layout.csv"
```

### Performance Tips

**Fast Development:**
```bash
# Use fast render mode
hugo server --bind 0.0.0.0 --port 1313
```

**Production Build:**
```bash
# Minify and optimize
hugo --minify --gc
```

## Technologies

- **Hugo** - Static site generator
- **PowerShell** - Automation scripting
- **CSS Grid/Flexbox** - Modern layout
- **JavaScript** - Interactivity

## License

MIT License 