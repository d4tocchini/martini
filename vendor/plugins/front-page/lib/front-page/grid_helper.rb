module GridHelper
  def grid_for(array, options = {}, &block)
    return "" if array.empty?
    columns = options[:columns] || 3
    (array / columns).each do |row|
      yield row
    end
  end
  
  def row_for(array, options = {}, &block)
    return "" if array.empty?
    array.each_with_index do |node, i|
      attributes = options.has_key?(:li_attributes) ? options[:li_attributes] : {}
      attributes[:class] ||= ""
      if i == 0 and options.has_key?(:first)
        attributes[:class] << "#{options[:first]}"
      elsif i == array.length - 1 and options.has_key?(:last)
        attributes[:class] << "#{options[:last]}"
      end
      haml_tag :li, attributes do
        if block_given?
          yield node, i
        else
          haml_concat node.title
        end
      end
    end
  end
end