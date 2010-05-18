require 'broadway'

# reset
if Rails.env == "development"
  Credentials.config = YAML.load_file("config/config.yml")
  puts "Destroying all Database data!"
  [Page, Post, Category, Configuration, Asset].each { |model| model.all.collect(&:destroy) }
end

# site
site = Broadway.build(:source => "db/sample")

# categories
site.categories.each_key do |name|
  category = Category.create(:name => name)
  puts "Category created... #{category.name.to_s}"
end

# assets
Dir.entries("public/system/martini")[2..-1].each do |path|
  asset = Asset.create(
    :data => File.join("public/system/martini", path),
    :title => File.basename(path).gsub(File.extname(path), "").titleize
  )
  puts "Asset created... #{asset.title.to_s}"
end

# pages
content = site.pages + site.posts
content.each do |page|
  categories = page.categories.collect { |category| Category.find_by_name(category) }
  result = Page.create(
    :title => page.title,
    :body => page.read,
    :layout => page.layout,
    :show_children => true,
    :format => page.content_type,
    :categories => categories,
    :tag_list => page.tags.join(", "),
    :published => true
  )
end

# get created elements
pages = Page.all
assets = Asset.all

# add children to pages
content.each do |item|
  page = pages.detect {|i| i.title == item.title}
  
  page.children = item.children.collect do |child|
    pages.detect {|i| i.title == child.title}
  end if item.respond_to?(:children)
  
  page.featured_image = assets[rand(assets.length - 1)]
  
  page.save
  puts "Page created... #{page.friendly_id}"
end