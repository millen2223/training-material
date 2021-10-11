require 'date'

module Jekyll
  class SitemapGenerator < Generator
    safe true

    def generate(site)
      puts "Generating Sitemap"
      result = '<?xml version="1.0" encoding="UTF-8"?>'
      result += '<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

      site.pages.each {|t|
        d = t.data['last_modified_at']
        d.format = '%FT%T%:z'
        result += "<url><loc>#{site.config['url'] + site.config['baseurl'] + t.url}</loc><lastmod>#{d}</lastmod></url>"
      }
      result += "</urlset>"

      page2 = PageWithoutAFile.new(site, "", '.', "sitemap.xml")
      page2.content = result
      site.pages << page2
    end
  end
end