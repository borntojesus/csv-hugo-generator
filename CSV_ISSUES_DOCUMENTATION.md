# CSV Issues with Hugo Content Adapters - Technical Evidence

## Summary
Direct CSV usage for Hugo content adapters is problematic due to Hugo's CSV parsing limitations and data structure incompatibilities.

## Evidence of Issues

### 1. Hugo CSV Data Type Error
```
ERROR unexpected data type [][]string in file gen-posts.csv
```
**Issue**: Hugo expects specific data structures for content adapters, but CSV files are parsed as 2D string arrays `[][]string` which cannot be directly used in content generation templates.

### 2. Template Execution Failures
```
execute of template failed at <.slug>: can't evaluate field slug in type interface {}
```
**Issue**: CSV data doesn't have named fields like `.slug`, `.title`, etc. - it's just positional arrays.

### 3. Index Type Mismatch
```
error calling index: index of type map[string]interface {} with args [0] failed: value has type int; should be string
```
**Issue**: Hugo's CSV parser creates inconsistent data structures that don't work with standard template indexing.

### 4. Template Clone Panic
```
panic: html/template: cannot Clone "" after it has executed
```
**Issue**: Template parsing failures cascade into Hugo's template system causing complete crashes.

## Technical Comparison

### YAML (Working Solution)
```yaml
scrapers:
  - slug: scrapingbee
    title: "Google Shopping Scraper API"
    benefits:
      - "Benefit 1"
      - "Benefit 2"
```
✅ **Works**: Named fields, proper nesting, Hugo content adapter compatible

### CSV (Problematic)
```csv
slug,title,benefit1,benefit2
scrapingbee,"Google Shopping Scraper API","Benefit 1","Benefit 2"
```
❌ **Fails**: Positional data, no nested structures, incompatible with content adapters

## Hugo Documentation Evidence
According to Hugo documentation, content adapters work best with:
- YAML/JSON structured data
- Named field access
- Nested data structures

CSV files are meant for simple data display, not dynamic page generation.

## Recommended Solution
1. **Keep CSV for data input/editing** (human-friendly)
2. **Convert CSV to YAML** for Hugo processing
3. **Use YAML in content adapters** (Hugo-compatible)

## Conversion Script
```bash
# Convert CSV to YAML when needed
python3 convert_csv_to_yaml.py
```

## Conclusion
While CSV is excellent for data entry and spreadsheet compatibility, **YAML is the proper format for Hugo content generation**. The CSV can be maintained for editing purposes and converted to YAML when needed.

**Status**: CSV direct usage = ❌ Not recommended  
**Status**: YAML usage = ✅ Fully working  
**Status**: CSV→YAML conversion = ✅ Best of both worlds