require 'broadway'

if Rails.env == "development"
  [Page, Post, Category, Configuration].each { |model| model.all.collect(&:destroy) }
end

# build data structure
site = Broadway.build(:source => "db/sample")

# categories
site.categories.each_key do |name|
  Category.create(:name => name)
end

content = site.pages + site.posts
# pages
content.each do |page|
  categories = page.categories.collect { |category| Category.find_by_name(category) }
  result = Page.create(
    :title => page.title,
    :body => page.read,
    :layout => page.layout,
    :show_children => true,
    :format => page.content_type,
    :categories => categories,
    :published => true
  )
end

# get created pages
pages = Page.all

# add children to pages
content.each do |item|
  page = pages.detect {|i| i.title == item.title}
  page.children = item.children.collect do |child|
    pages.detect {|i| i.title == child.title}
  end if item.respond_to?(:children)
  page.save
  puts "Page complete... #{page.friendly_id}"
end