# since I love the haml pretty-printed output so much,
# this makes it so I can use that instead of the built in
# rails ugly printing
module FrontPage::Adapter
  def render_tag(name, *args, &block)
    if self.respond_to?("is_haml?".to_sym) and is_haml?
      haml_tag(name.to_sym, options)
    else
      tag(name.to_sym)
    end
  end
end