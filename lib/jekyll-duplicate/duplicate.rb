module Jekyll
  class DuplicatePage < Page
    def initialize(site, base_dir, url_prefix, path, content, data, overrides, format)
      @site = site
      @base = base_dir
      @content = content

      if format == 'html'
        if path.end_with?('/index')
          @dir = url_prefix
        else
          @dir = File.join(url_prefix, path)
        end
        @name = "index.html"

      elsif format == 'json'
        @dir = File.join(url_prefix)
        @name = "#{path}.json"
      end

      self.process(@name)

      self.data = data.clone

      if overrides
        if overrides['frontmatter']
          overrides['frontmatter'].each do |key, value|
            self.data[key] = value
          end
        end
        if overrides['layout']
          self.data['layout'] = overrides['layout']
        end
      end
    end
  end

  class Site
    def write_duplicate_docs(collection_name, url_prefix, layout, frontmatter, format)
      overrides = {
        "layout" => layout,
        "frontmatter" => frontmatter,
      }

      originals = @collections[collection_name]

      originals.docs.each do |doc|
        if doc.data['permalink']
          permalink = doc.data['permalink'].sub("/#{collection_name}/", '')
        else
          permalink = doc.cleaned_relative_path
        end

        page = DuplicatePage.new(
          self,
          self.source,
          url_prefix,
          permalink,
          doc.content,
          doc.data,
          overrides,
          format)

        @pages << page
      end
    end
  end
end


Jekyll::Hooks.register :site, :post_read do |site|
  if site.config.key?('duplicate_documents')
    cfg = site.config['duplicate_documents']
    site.write_duplicate_docs(
      cfg['in_collection'],
      cfg['under_url_prefix'],
      cfg['with_layout'],
      cfg['with_frontmatter'],
      cfg['format'])
  end
end
