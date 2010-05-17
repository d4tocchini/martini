module NavigationHelper
  
  def menu_for(item, options = {}, &block)
    if item.is_a?(Page)
      menu_tag(item.children, options, &block)
    elsif item.is_a?(Post)
      ""
    else
      menu_tag(item, options, &block)
    end
  end
  
  # - menu_tag(c(:menu)) do |attributes, node|
  # 	- attributes[:class] = "one two"
  # 	- node[:title]
  def menu_tag(array, options = {}, &block)
    return "" if array.empty?
    menu_attributes = nil
    if options.has_key?(:menu_attributes)
      menu_attributes = options[:menu_attributes]
      options.delete(:menu_attributes)
    end
    haml_tag :ul, menu_attributes do
      array.each_with_index do |node, i|
        attributes = options.has_key?(:li_attributes) ? options[:li_attributes] : {}
        attributes[:class] ||= ""
        if i == 0 and options.has_key?(:first)
          attributes[:class] << " #{options[:first]}"
        elsif i == array.length - 1 and options.has_key?(:last)
          attributes[:class] << " #{options[:last]}"
        end
        haml_tag :li, attributes do
          if block_given?
            yield node
          else
            haml_concat node.title
          end
          next unless (node.respond_to?(:children))
          menu_tag(node.children, options, &block)
        end
      end
    end
  end
  
  def breadcrumb_for(item, options = {}, &block)
    options[:from] ||= "/" + item.url.gsub(/^\//, "").split("/").first
    options[:to] ||= item.url
    breadcrumb(options[:from], options, &block)
  end
  
  def breadcrumb(current_url, options, &block)
    item = site.find_by_url(current_url)
    return "" unless item
    haml_tag :a, options.merge(:href => current_url) do
      if block_given?
        yield item
      else
        haml_concat item.title
      end
    end
    if options[:to] != current_url
      haml_concat options[:delimiter] || " » "
      next_node = options[:to].gsub(/#{current_url}\/?/, "").split("/").first
      breadcrumb("#{current_url}/#{next_node}", options, &block)
    end
  end
end