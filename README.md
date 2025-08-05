# CSV to Hugo Programmatic Pages Generator

A Hugo static site that dynamically generates web development service pages from CSV data using Hugo's content adapters.

## 🔗 Quick Links

- **📊 [CSV Data](assets/gen-posts.csv)** - View the source data file

## 🚀 Features

- **CSV-Driven Content**: Automatically generate service pages from CSV data
- **Hugo Content Adapters**: Leverage Hugo's modern content generation features
- **11 Development Services**: Pre-configured pages for popular web technologies
- **Netlify Ready**: Optimized deployment configuration with caching headers
- **SEO Optimized**: Meta descriptions, structured content, and performance-focused

## 📋 Generated Service Pages

The site automatically creates pages for these development services:
- Hugo Development
- React Development  
- Next.js Development
- Node.js Development
- Vue.js Development
- Angular Development
- JAMstack Development
- Astro Development
- Gatsby Development
- Nuxt.js Development
- Eleventy Development

## 🏗️ Project Structure

```
csv-hugo-generator/
├── assets/gen-posts.csv          # CSV data source for page generation
├── content/scrapers/             # Content generation templates
│   └── _content.gotmpl          # Go template for CSV-to-Hugo conversion
├── data/                        # Hugo data directory
├── layouts/                     # Hugo layout templates
│   ├── _default/baseof.html     # Base template
│   ├── index.html               # Homepage layout
│   └── scrapers/                # Service page layouts
├── hugo.yaml                    # Hugo configuration
├── netlify.toml                 # Netlify deployment settings
└── public/                      # Generated static files
```

## 🛠️ Development

### Prerequisites

- [Hugo](https://gohugo.io/installation/) v0.120.0 or later
- Node.js (for development tools, if needed)

### Local Development

1. **Clone and start development server:**
   ```bash
   hugo server
   ```

2. **Access the site:**
   ```
   http://localhost:1313
   ```

3. **Live reload is enabled** - changes to templates and CSV data will automatically rebuild the site.

### Adding New Services

1. **Edit the CSV file** (`assets/gen-posts.csv`):
   ```csv
   slug,title_tag_goes_here,meta_description_goes_here,hero_section_heading,hero_section_intro,benefit_variable_1,benefit_variable_2,benefit_variable_3
   new-service,New Service | Title,Meta description,Hero Heading,Hero intro text,Benefit 1,Benefit 2,Benefit 3
   ```

2. **Hugo will automatically generate** a new page at `/scrapers/new-service/`

### CSV Data Structure

Each row contains:
- `slug`: URL path segment
- `title_tag_goes_here`: Page title for SEO
- `meta_description_goes_here`: Meta description
- `hero_section_heading`: Main heading on the page
- `hero_section_intro`: Introduction text
- `benefit_variable_1-3`: Three key benefits/features

## 🚀 Deployment

### Netlify (Recommended)

The project is pre-configured for Netlify deployment:

1. **Connect your repository** to Netlify
2. **Build settings are automatic** (reads from `netlify.toml`)
3. **Environment variables**: 
   - Hugo Version: 0.120.0
   - Build Command: `hugo`
   - Publish Directory: `public`

### Manual Build

```bash
# Build for production
hugo --environment production

# Output will be in ./public/
```

## 🔧 Configuration

### Hugo Settings (`hugo.yaml`)

- **Content Adapters**: Enabled for CSV-to-content generation
- **Build Stats**: Enabled for performance monitoring
- **Multiple Output Formats**: HTML and RSS feeds

### Netlify Settings (`netlify.toml`)

- **Security Headers**: XSS protection, content type sniffing prevention
- **Caching Strategy**: Long-term caching for static assets
- **Environment-Specific Builds**: Production, staging, and preview configurations

## 📝 Content Management

### How It Works

1. **CSV Data Source**: `assets/gen-posts.csv` contains all service information
2. **Content Adapter**: `content/scrapers/_content.gotmpl` processes the CSV
3. **Page Generation**: Hugo creates individual pages for each CSV row
4. **Layout Application**: Pages use layouts from `layouts/scrapers/`

### Benefits of This Approach

- **Easy Content Updates**: Modify CSV file to update all services
- **Consistent Structure**: All service pages follow the same template
- **Scalable**: Add unlimited services without creating new files
- **Version Control Friendly**: Track content changes in CSV format

## 🐛 Troubleshooting

### Common Issues

1. **CSV parsing errors**: Ensure proper comma separation and quoted fields with commas
2. **Missing pages**: Check CSV format and Hugo server logs
3. **Build failures**: Verify Hugo version compatibility (0.120.0+)

### Debug Mode

```bash
# Run Hugo with verbose logging
hugo server --verbose --debug
```

## 📄 License

MIT License - feel free to use this project as a template for your own CSV-driven Hugo sites.