# PowerShell script to generate Hugo content from CSV data
# This script reads the CSV file and creates Hugo markdown files for each scraper

param(
    [string]$CsvPath = "Copy of Alpina _ SBee - Example - Horizontal Layout.csv",
    [string]$OutputPath = "content/scrapers"
)

# Function to clean text content
function Clean-Text {
    param([string]$Text)
    
    # Remove HTML tags and variable placeholders
    $Text = $Text -replace '<[^>]*>', ''
    $Text = $Text -replace '\{[^}]*\}', ''
    $Text = $Text.Trim()
    
    return $Text
}

# Function to read CSV with duplicate column handling
function Read-CsvWithDuplicates {
    param([string]$FilePath)
    
    # Read CSV as raw text first
    $csvContent = Get-Content -Path $FilePath -Encoding UTF8
    
    # Get headers and handle duplicates
    $headers = $csvContent[0] -split ','
    $uniqueHeaders = @()
    $headerCounts = @{}
    
    foreach ($header in $headers) {
        $cleanHeader = $header.Trim('"')
        if ($headerCounts.ContainsKey($cleanHeader)) {
            $headerCounts[$cleanHeader]++
            $uniqueHeaders += "$cleanHeader`_$($headerCounts[$cleanHeader])"
        } else {
            $headerCounts[$cleanHeader] = 1
            $uniqueHeaders += $cleanHeader
        }
    }
    
    # Create temporary CSV with unique headers
    $tempCsv = @($uniqueHeaders -join ',')
    for ($i = 1; $i -lt $csvContent.Count; $i++) {
        $tempCsv += $csvContent[$i]
    }
    
    # Write temporary file
    $tempFile = [System.IO.Path]::GetTempFileName()
    $tempCsv | Out-File -FilePath $tempFile -Encoding UTF8
    
    # Read CSV with unique headers
    $csv = Import-Csv -Path $tempFile -Encoding UTF8
    
    # Clean up temp file
    Remove-Item -Path $tempFile -Force
    
    return $csv
}

# Function to extract variables from CSV row
function Get-VariablesFromRow {
    param([object]$Row)
    
    $variables = @{
        # Meta variables
        meta_title = Clean-Text $Row.'Meta title'
        meta_description = Clean-Text $Row.'Meta description'
        
        # Hero section variables (handle multiple HERO columns)
        hero_section_heading = Clean-Text $Row.'HERO'
        hero_section_intro = Clean-Text $Row.'HERO_2'
        
        # Benefit variables
        benefit_1 = Clean-Text $Row.'HERO_3'
        benefit_2 = Clean-Text $Row.'HERO_4'
        benefit_3 = Clean-Text $Row.'HERO_5'
        
        # Use case variables (handle multiple BELOW THE FOLD columns)
        use_case_heading = Clean-Text $Row.'BELOW THE FOLD'
        use_case_intro = Clean-Text $Row.'BELOW THE FOLD_2'
        use_case_1_heading = Clean-Text $Row.'BELOW THE FOLD_3'
        use_case_1_description = Clean-Text $Row.'BELOW THE FOLD_4'
        use_case_2_heading = Clean-Text $Row.'BELOW THE FOLD_5'
        use_case_2_description = Clean-Text $Row.'BELOW THE FOLD_6'
        use_case_3_heading = Clean-Text $Row.'BELOW THE FOLD_7'
        use_case_3_description = Clean-Text $Row.'BELOW THE FOLD_8'
        
        # Pricing variables
        pricing_heading = Clean-Text $Row.'PRICING'
        pricing_intro = Clean-Text $Row.'PRICING_2'
        
        # How it works variables (handle multiple HOW SCRAPING BEE WORKS columns)
        how_it_works_heading = Clean-Text $Row.'HOW SCRAPING BEE WORKS'
        how_it_works_intro = Clean-Text $Row.'HOW SCRAPING BEE WORKS_2'
        step_1 = Clean-Text $Row.'HOW SCRAPING BEE WORKS_3'
        step_2 = Clean-Text $Row.'HOW SCRAPING BEE WORKS_4'
        step_3 = Clean-Text $Row.'HOW SCRAPING BEE WORKS_5'
        step_4 = Clean-Text $Row.'HOW SCRAPING BEE WORKS_6'
        
        # Features variables (handle multiple FEATURES SECTION columns)
        features_heading = Clean-Text $Row.'FEATURES SECTION'
        features_intro = Clean-Text $Row.'FEATURES SECTION_2'
        feature_1_heading = Clean-Text $Row.'FEATURES SECTION_3'
        feature_1_description = Clean-Text $Row.'FEATURES SECTION_4'
        feature_2_heading = Clean-Text $Row.'FEATURES SECTION_5'
        feature_2_description = Clean-Text $Row.'FEATURES SECTION_6'
        feature_3_heading = Clean-Text $Row.'FEATURES SECTION_7'
        feature_3_description = Clean-Text $Row.'FEATURES SECTION_8'
        feature_4_heading = Clean-Text $Row.'FEATURES SECTION_9'
        feature_4_description = Clean-Text $Row.'FEATURES SECTION_10'
        feature_5_heading = Clean-Text $Row.'FEATURES SECTION_11'
        feature_5_description = Clean-Text $Row.'FEATURES SECTION_12'
        feature_6_heading = Clean-Text $Row.'FEATURES SECTION_13'
        feature_6_description = Clean-Text $Row.'FEATURES SECTION_14'
        
        # Testimonials variables
        testimonials_heading = Clean-Text $Row.'TESTIMONIALS'
        client_logo_heading = Clean-Text $Row.'CLIENT LOGO'
        
        # Data coverage variables (handle multiple DATA COVERAGE columns)
        data_coverage_heading = Clean-Text $Row.'DATA COVERAGE'
        data_coverage_intro = Clean-Text $Row.'DATA COVERAGE_2'
        coverage_1_heading = Clean-Text $Row.'DATA COVERAGE_3'
        coverage_1_description = Clean-Text $Row.'DATA COVERAGE_4'
        coverage_2_heading = Clean-Text $Row.'DATA COVERAGE_5'
        coverage_2_description = Clean-Text $Row.'DATA COVERAGE_6'
        
        # Internal stats variables
        stats_heading = Clean-Text $Row.'INTERNAL STATS'
        stats_intro = Clean-Text $Row.'INTERNAL STATS_2'
        
        # Tutorials variables (handle multiple LINKS TO TUTORIALS columns)
        tutorials_heading = Clean-Text $Row.'LINKS TO TUTORIALS'
        tutorial_1_heading = Clean-Text $Row.'LINKS TO TUTORIALS_2'
        tutorial_1_description = Clean-Text $Row.'LINKS TO TUTORIALS_3'
        tutorial_2_heading = Clean-Text $Row.'LINKS TO TUTORIALS_4'
        tutorial_2_description = Clean-Text $Row.'LINKS TO TUTORIALS_5'
        tutorial_3_heading = Clean-Text $Row.'LINKS TO TUTORIALS_6'
        tutorial_3_description = Clean-Text $Row.'LINKS TO TUTORIALS_7'
        
        # Developer experience variables (handle multiple DEVELOPER EXPERIENCE columns)
        dev_experience_heading = Clean-Text $Row.'DEVELOPER EXPERIENCE'
        dev_experience_intro = Clean-Text $Row.'DEVELOPER EXPERIENCE_2'
        dev_feature_1_heading = Clean-Text $Row.'DEVELOPER EXPERIENCE_3'
        dev_feature_1_description = Clean-Text $Row.'DEVELOPER EXPERIENCE_4'
        dev_feature_2_heading = Clean-Text $Row.'DEVELOPER EXPERIENCE_5'
        dev_feature_2_description = Clean-Text $Row.'DEVELOPER EXPERIENCE_6'
        dev_feature_3_heading = Clean-Text $Row.'DEVELOPER EXPERIENCE_7'
        dev_feature_3_description = Clean-Text $Row.'DEVELOPER EXPERIENCE_8'
        dev_feature_4_heading = Clean-Text $Row.'DEVELOPER EXPERIENCE_9'
        dev_feature_4_description = Clean-Text $Row.'DEVELOPER EXPERIENCE_10'
        dev_feature_5_heading = Clean-Text $Row.'DEVELOPER EXPERIENCE_11'
        dev_feature_5_description = Clean-Text $Row.'DEVELOPER EXPERIENCE_12'
        
        # Documentation variables (handle multiple LINKS TO DOC columns)
        docs_heading = Clean-Text $Row.'LINKS TO DOC'
        docs_intro = Clean-Text $Row.'LINKS TO DOC_2'
        doc_link_1 = Clean-Text $Row.'LINKS TO DOC_3'
        doc_link_2 = Clean-Text $Row.'LINKS TO DOC_4'
        doc_link_3 = Clean-Text $Row.'LINKS TO DOC_5'
        doc_link_4 = Clean-Text $Row.'LINKS TO DOC_6'
        
        # Scraper tools variables (handle multiple LINKS TO SCRAPER TOOLS columns)
        tools_heading = Clean-Text $Row.'LINKS TO SCRAPER TOOLS'
        tool_1 = Clean-Text $Row.'LINKS TO SCRAPER TOOLS_2'
        tool_2 = Clean-Text $Row.'LINKS TO SCRAPER TOOLS_3'
        tool_3 = Clean-Text $Row.'LINKS TO SCRAPER TOOLS_4'
        tool_4 = Clean-Text $Row.'LINKS TO SCRAPER TOOLS_5'
        tool_5 = Clean-Text $Row.'LINKS TO SCRAPER TOOLS_6'
        tool_6 = Clean-Text $Row.'LINKS TO SCRAPER TOOLS_7'
        
        # FAQ variables (handle multiple FAQs columns)
        faq_heading = Clean-Text $Row.'FAQs'
        faq_1_question = Clean-Text $Row.'FAQs_2'
        faq_1_answer = Clean-Text $Row.'FAQs_3'
        faq_2_question = Clean-Text $Row.'FAQs_4'
        faq_2_answer = Clean-Text $Row.'FAQs_5'
        faq_3_question = Clean-Text $Row.'FAQs_6'
        faq_3_answer = Clean-Text $Row.'FAQs_7'
        faq_4_question = Clean-Text $Row.'FAQs_8'
        faq_4_answer = Clean-Text $Row.'FAQs_9'
        faq_5_question = Clean-Text $Row.'FAQs_10'
        faq_5_answer = Clean-Text $Row.'FAQs_11'
        faq_6_question = Clean-Text $Row.'FAQs_12'
        faq_6_answer = Clean-Text $Row.'FAQs_13'
        
        # Blog links variables (handle multiple LINKS TO BLOGS columns)
        blog_heading = Clean-Text $Row.'LINKS TO BLOGS'
        blog_1_heading = Clean-Text $Row.'LINKS TO BLOGS_2'
        blog_1_description = Clean-Text $Row.'LINKS TO BLOGS_3'
        blog_2_heading = Clean-Text $Row.'LINKS TO BLOGS_4'
        blog_2_description = Clean-Text $Row.'LINKS TO BLOGS_5'
        blog_3_heading = Clean-Text $Row.'LINKS TO BLOGS_6'
        blog_3_description = Clean-Text $Row.'LINKS TO BLOGS_7'
    }
    
    return $variables
}

# Function to create Hugo front matter with variables
function New-HugoFrontMatter {
    param(
        [string]$Title,
        [string]$Description,
        [string]$ScraperName,
        [string]$Url,
        [hashtable]$Variables
    )
    
    $frontMatter = @"
---
title: "$Title"
description: "$Description"
scraper_name: "$ScraperName"
date: $(Get-Date -Format "yyyy-MM-dd")
draft: false
layout: scraper
url: "$Url"
aliases: ["/$($ScraperName.ToLower().Replace(' ', '-'))/"]
variables:
"@
    
    # Add variables to front matter
    foreach ($key in $Variables.Keys) {
        $value = $Variables[$key]
        if ($value -and $value -ne "") {
            $frontMatter += "`n  $key`: `"$value`""
        }
    }
    
    $frontMatter += "`n---`n`n"
    
    return $frontMatter
}

# Function to create Hugo content with variables
function New-HugoContent {
    param(
        [string]$ScraperName,
        [hashtable]$Variables
    )
    
    $content = @"

# $($Variables.hero_heading)

$($Variables.hero_intro)

"@
    
    # Add benefits section if available
    if ($Variables.benefit_1 -or $Variables.benefit_2 -or $Variables.benefit_3) {
        $content += "## Benefits`n`n"
        if ($Variables.benefit_1) { $content += "- $($Variables.benefit_1)`n" }
        if ($Variables.benefit_2) { $content += "- $($Variables.benefit_2)`n" }
        if ($Variables.benefit_3) { $content += "- $($Variables.benefit_3)`n" }
        $content += "`n"
    }
    
    # Add use cases section if available
    if ($Variables.use_case_heading -or $Variables.use_case_intro) {
        $content += "## $($Variables.use_case_heading)`n`n"
        $content += "$($Variables.use_case_intro)`n`n"
        
        if ($Variables.use_case_1_heading -and $Variables.use_case_1_description) {
            $content += "### $($Variables.use_case_1_heading)`n`n"
            $content += "$($Variables.use_case_1_description)`n`n"
        }
        
        if ($Variables.use_case_2_heading -and $Variables.use_case_2_description) {
            $content += "### $($Variables.use_case_2_heading)`n`n"
            $content += "$($Variables.use_case_2_description)`n`n"
        }
        
        if ($Variables.use_case_3_heading -and $Variables.use_case_3_description) {
            $content += "### $($Variables.use_case_3_heading)`n`n"
            $content += "$($Variables.use_case_3_description)`n`n"
        }
    }
    
    # Add features section if available
    if ($Variables.features_heading -or $Variables.features_intro) {
        $content += "## $($Variables.features_heading)`n`n"
        $content += "$($Variables.features_intro)`n`n"
        
        # Add individual features
        for ($i = 1; $i -le 6; $i++) {
            $heading = $Variables["feature_${i}_heading"]
            $description = $Variables["feature_${i}_description"]
            if ($heading -and $description) {
                $content += "### $heading`n`n"
                $content += "$description`n`n"
            }
        }
    }
    
    # Add how it works section if available
    if ($Variables.how_it_works_heading -or $Variables.how_it_works_intro) {
        $content += "## $($Variables.how_it_works_heading)`n`n"
        $content += "$($Variables.how_it_works_intro)`n`n"
        
        if ($Variables.step_1) { $content += "### Step 1`n`n$($Variables.step_1)`n`n" }
        if ($Variables.step_2) { $content += "### Step 2`n`n$($Variables.step_2)`n`n" }
        if ($Variables.step_3) { $content += "### Step 3`n`n$($Variables.step_3)`n`n" }
        if ($Variables.step_4) { $content += "### Step 4`n`n$($Variables.step_4)`n`n" }
    }
    
    # Add FAQ section if available
    if ($Variables.faq_heading) {
        $content += "## $($Variables.faq_heading)`n`n"
        
        for ($i = 1; $i -le 6; $i++) {
            $question = $Variables["faq_${i}_question"]
            $answer = $Variables["faq_${i}_answer"]
            if ($question -and $answer) {
                $content += "### $question`n`n"
                $content += "$answer`n`n"
            }
        }
    }
    
    return $content
}

# Main execution
Write-Host "Starting CSV to Hugo content generation with variables..." -ForegroundColor Green

# Check if CSV file exists
if (-not (Test-Path $CsvPath)) {
    Write-Error "CSV file not found: $CsvPath"
    exit 1
}

# Create output directory if it doesn't exist
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Read CSV file with duplicate handling
try {
    $csv = Read-CsvWithDuplicates -FilePath $CsvPath
    Write-Host "Successfully loaded CSV with $($csv.Count) rows" -ForegroundColor Green
} catch {
    Write-Error "Failed to read CSV file: $_"
    exit 1
}

# Process each row (skip header rows)
$processedCount = 0
foreach ($row in $csv) {
    # Skip header rows and examples
    if ($row.'Scraper name' -and 
        $row.'Scraper name' -ne "HTML tag" -and 
        $row.'Scraper name' -ne "Variable placeholder" -and
        $row.'Scraper name' -notlike "*Example*") {
        
        $scraperName = Clean-Text $row.'Scraper name'
        $metaTitle = Clean-Text $row.'Meta title'
        $metaDescription = Clean-Text $row.'Meta description'
        
        # Extract all variables from the row
        $variables = Get-VariablesFromRow -Row $row
        
        # Create URL-friendly filename
        $filename = $scraperName.ToLower() -replace '[^a-z0-9\s-]', '' -replace '\s+', '-'
        $filePath = Join-Path $OutputPath "$filename.md"
        
        # Create front matter with variables
        $frontMatter = New-HugoFrontMatter -Title $metaTitle -Description $metaDescription -ScraperName $scraperName -Url "/scrapers/$filename/" -Variables $variables
        
        # Create content with variables
        $content = New-HugoContent -ScraperName $scraperName -Variables $variables
        
        # Write file
        $fullContent = $frontMatter + $content
        $fullContent | Out-File -FilePath $filePath -Encoding UTF8
        
        Write-Host "Created: $filename.md with variables" -ForegroundColor Yellow
        $processedCount++
    }
}

Write-Host "Generation complete! Created $processedCount content files with variables." -ForegroundColor Green
Write-Host "Files saved to: $OutputPath" -ForegroundColor Cyan

# Additional feature: Create a data summary with variables
$summaryPath = "data/scrapers-summary.json"

# Create data directory if it doesn't exist
$dataDir = Split-Path -Parent $summaryPath
if (-not (Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir -Force | Out-Null
    Write-Host "Created data directory: $dataDir" -ForegroundColor Yellow
}

$summary = @{
    total_scrapers = $processedCount
    generated_date = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    scrapers = @()
}

foreach ($row in $csv) {
    if ($row.'Scraper name' -and 
        $row.'Scraper name' -ne "HTML tag" -and 
        $row.'Scraper name' -ne "Variable placeholder" -and
        $row.'Scraper name' -notlike "*Example*") {
        
        $variables = Get-VariablesFromRow -Row $row
        $scraperSummary = @{
            name = Clean-Text $row.'Scraper name'
            title = Clean-Text $row.'Meta title'
            description = Clean-Text $row.'Meta description'
            variables = $variables
        }
        $summary.scrapers += $scraperSummary
    }
}

$summary | ConvertTo-Json -Depth 10 | Out-File -FilePath $summaryPath -Encoding UTF8
Write-Host "Created summary file with variables: $summaryPath" -ForegroundColor Cyan 