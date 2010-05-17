module HeadHelper
  
  def meta(options = {})
    title(options[:title]) if options.has_key?(:title)
    description(options[:description]) if options.has_key?(:description)
    keywords(options[:keywords]) if options.has_key?(:keywords)
    copyright(options[:copyright]) if options.has_key?(:copyright)
  end
  
  def meta_tags(*args)
    options = args.extract_options!
    site = options[:site] || args.first
    result = title_tag(site, options[:title])
    result << "\n"
    result << content_type_tag
    result << "\n"
    result << description_tag(options[:description])
    result << "\n"
    result << keywords_tag(options[:keywords])
    result << "\n"
    result << copyright_tag(options[:copyright])
    result
  end
  
  # country
  # classification
  # author
  # apple-mobile-web-app-capable
  # apple-touch-fullscreen
  # google-analytics
  # Revisit-After
  # category
  def meta_tag(name, content = '')
    tag(:meta, :name => name, :content => content)
  end
  
  def title(string)
    @content_for_title = string
  end
  
  def title_tag(*args)
    options = args.extract_options!
    
    site = options[:site] || args.first
    # Prefix (leading space)
    if options[:prefix]
      prefix = options[:prefix]
    elsif options[:prefix] === false
      prefix = ''
    else
      prefix = ' '
    end
    
    # Separator
    unless options[:separator].blank?
      separator = options[:separator]
    else
      separator = '|'
    end
  
    # Suffix (trailing space)
    if options[:suffix]
      suffix = options[:suffix]
    elsif options[:suffix] === false
      suffix = ''
    else
      suffix = ' '
    end

    # Title
    title = @content_for_title
    if options[:lowercase] === true
      title = title.downcase unless title.blank?
    end
    
    # title
    if title.blank?
      result = content_tag :title, site
    else
      title = normalize_title(title)
      title = [site] + title
      title.reverse! if options[:reverse] === true
      sep = prefix + separator + suffix
      result = content_tag(:title, title.join(sep))
    end
    result
  end
  
  def description(string)
    @content_for_description = string
  end

  def description_tag(default='')
    content = normalize_description(@content_for_description || default)
    tag(:meta, :name => :description, :content => content) unless content.blank?
  end

  def keywords(string)
    @content_for_keywords = string
  end

  def keywords_tag(default = '')
    content = normalize_keywords(@content_for_keywords || default)
    tag(:meta, :name => :keywords, :content => content) unless content.blank?
  end

  def copyright(string)
    @content_for_copyright = string
  end

  def copyright_tag(default='')
    content = @content_for_copyright || default
    tag(:meta, :name => :copyright, :content => content) unless content.blank?
  end
  
  def robots(*args)
    content_for(:robots, args.join(", "))
  end
  
  def robots_tag(*args)
    options = args.extract_options!
    
    noindex_name = tags[:noindex].is_a?(String) ? tags[:noindex] : 'robots'
    nofollow_name = tags[:nofollow].is_a?(String) ? tags[:nofollow] : 'robots'

    if noindex_name == nofollow_name
      content = [(tags[:noindex] ? 'noindex' : nil), (tags[:nofollow] ? 'nofollow' : nil)].compact.join(', ')
      unless content.blank?
        result << "\n"
        result << tag(:meta, :name => noindex_name, :content => content)
      end
    else
      if tags[:noindex]
        result << "\n"
        result << tag(:meta, :name => noindex_name, :content => 'noindex')
      end
      if tags[:nofollow]
        result << "\n"
        result << tag(:meta, :name => nofollow_name, :content => 'nofollow')
      end
    end
    # canonical
    unless tags[:canonical].blank?
      result << "\n"
      result << tag(:link, :rel => :canonical, :href => tags[:canonical]) 
    end

    return result
  end
  
  def copyright(from)
    now = Time.now.year
    now.eql?(from) ? now : "#{from} - #{now}"
  end
  
  # Apple
  # http://developer.apple.com/safari/library/documentation/AppleApplications/Reference/SafariHTMLRef/Articles/MetaTags.html
  
  # Facebook (and opengraph)
  # http://developers.facebook.com/docs/opengraph#types
  
  # http://wiki.developers.facebook.com/index.php/Facebook_Share/Specifying_Meta_Tags
  def snapshot_tag(href)
    tag(:link, :rel => "image_src", :href => href)
  end
  
  # http://wiki.developers.facebook.com/index.php/Facebook_Share/Specifying_Meta_Tags
  def medium(type)
    tag(:meta, :name => :medium, :content => type)
  end
  
  def classification(type)
    tag(:meta, :name => "og:type", :content => type)
  end
  
  def content_type_tag(type = "text/html", charset = "UTF-8")
    meta_tag("Content-Type", "#{type}; charset=#{charset}")
  end
  
  def search_link_tag(href, title)
    link_tag({:rel => "search", :type => "application/opensearchdescription+xml", :href => href, :title => title})
  end  
  
  def favicon_link_tag(favicon = "/favicon.ico")
    link_tag({:rel => "shortcut icon", :href => favicon, :type => "image/x-icon"})
  end
  
  def link_tag(options = {})
    tag(:link, options)
  end
  
  private

    def normalize_title(title)
      if title.is_a? String
        title = [title]
      end
      title.map { |t| h(strip_tags(t)) }
    end
  
    def normalize_description(description)
      return '' unless description
      truncate(strip_tags(description).gsub(/\s+/, ' '), :length => 200)
    end
  
    def normalize_keywords(keywords)
      return '' unless keywords
      keywords = keywords.flatten.join(', ') if keywords.is_a?(Array)
      strip_tags(keywords).mb_chars.downcase
    end
end
ActionView::Base.send :include, HeadHelper