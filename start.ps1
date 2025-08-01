

Write-Host "🚀 Starting ScrapingBee Hugo Site..." -ForegroundColor Green

# Step 1: Generate content from CSV
Write-Host "📊 Generating content from CSV..." -ForegroundColor Yellow
powershell -ExecutionPolicy Bypass -File generate-content.ps1

# Step 2: Start Hugo server
Write-Host "🌐 Starting Hugo server..." -ForegroundColor Yellow
Write-Host "📱 Site will be available at: http://localhost:1313" -ForegroundColor Cyan
Write-Host "🛑 Press Ctrl+C to stop the server" -ForegroundColor Red

hugo server --bind 0.0.0.0 --port 1313 