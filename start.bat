@echo off
REM Auto-start script for ScrapingBee Hugo site (Windows)
REM This script generates content and starts Hugo server

echo 🚀 Starting ScrapingBee Hugo Site...

REM Step 1: Generate content from CSV
echo 📊 Generating content from CSV...
powershell -ExecutionPolicy Bypass -File generate-content.ps1

REM Step 2: Start Hugo server
echo 🌐 Starting Hugo server...
echo 📱 Site will be available at: http://localhost:1313
echo 🛑 Press Ctrl+C to stop the server

hugo server --bind 0.0.0.0 --port 1313 