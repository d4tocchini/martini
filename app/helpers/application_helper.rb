module ApplicationHelper
  def header(string)
    content_for(:header, content_tag(:h1, string))
    title(string)
  end
  
  def nested_path(object)
    CGI.unescape(send("#{object.class.name.downcase}_path", object))
  end
  
  def nested_admin_path(object)
    CGI.unescape(send("admin_#{object.class.name.downcase}_path", object))
  end
  
  def edit_nested_admin_path(object)
    CGI.unescape(send("edit_admin_#{object.class.name.downcase}_path", object))
  end
end
