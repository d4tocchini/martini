def require_local(path, from = __FILE__)
  files(path, from) {|file| require file if File.extname(file) == ".rb"}
end

def files(path, from = __FILE__, &block)
  Dir.glob(File.expand_path(File.join(File.dirname(from), path))) {|file| yield file}
end
# This takes care of the rest of functionality you need
# for an SEO and easy to build page.
# It includes: metadata helpers, grid helpers (e.g. for photo gallerys),
# navigation helpers (menus and breadcrumbs),
# better render method so you can pass a block to partials
module FrontPage
  
end
# http://github.com/rpheath/navigation_helper.git
# http://github.com/justinfrench/lovely-layouts.git
# http://github.com/ianwhite/truncate_html
# http://github.com/dekart/breadcrumbs.git
# http://github.com/html/once/blob/master/lib/once.rb
# http://github.com/fnando/breadcrumbs.git
# http://github.com/semanticart/smart-meta

require_local "front-page/*"

FrontPage.send(:include, FrontPage::HeadHelper)
FrontPage.send(:include, FrontPage::BodyHelper)
FrontPage.send(:include, FrontPage::NavigationHelper)
ActionView::Base.send :include, FrontPage