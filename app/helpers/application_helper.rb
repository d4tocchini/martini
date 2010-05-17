module ApplicationHelper
  def header(string)
    content_for(:header, content_tag(:h1, string))
    title(string)
  end
end
