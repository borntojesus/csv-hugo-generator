# Quick Start Guide

## 🚀 Get Started in 3 Steps

### 1. Install Hugo

**Windows:**
- Download from https://gohugo.io/installation/
- Extract to `C:\Hugo\bin`
- Add to PATH: `C:\Hugo\bin`

**Linux/macOS:**
```bash
sudo apt update && sudo apt install hugo

brew install hugo
```

### 2. Generate Content

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File generate-content.ps1
```

**Linux/macOS:**
```bash
powershell -ExecutionPolicy Bypass -File generate-content.ps1
```

### 3. Start Server

```bash
hugo server --bind 0.0.0.0 --port 1313
```

Visit: http://localhost:1313

## 🔧 One-Command Setup

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File start.ps1
```

**Linux/macOS:**
```bash
powershell -ExecutionPolicy Bypass -File generate-content.ps1

hugo server --bind 0.0.0.0 --port 1313
```

## 📁 Project Files

- `generate-content.ps1` - Generates Hugo content from all CSV files
- `start.ps1` - Complete setup script (Windows)
- `start.bat` - Complete setup script (Windows CMD)
- `config.toml` - Hugo configuration
- `*.csv` - Data source files (supports multiple CSV files)

## 🌐 Access Points

- **Homepage:** http://localhost:1313/
- **Scraper List:** http://localhost:1313/scrapers/
- **Individual Scrapers:** http://localhost:1313/scrapers/[scraper-name]/

## 🛠️ Troubleshooting

**PowerShell Error:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Port in Use:**
```bash
hugo server --bind 0.0.0.0 --port 1314
```

**Hugo Not Found:**
```bash
hugo version
