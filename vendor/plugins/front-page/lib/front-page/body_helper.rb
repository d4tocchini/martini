module BodyHelper  
  def body_id(string)
    @body_id = string
  end
  
  def body_class(string)
    @body_class = string
  end
  
  def body_attributes(options = {})
    options[:class] ||= @body_class || "default_body_class"
    options[:id] ||= @body_id || "default_body_id"
    
    options
  end
end