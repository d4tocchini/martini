# Martini

This was just put together this weekend.  It's semi-functional but should be working by the end of the week.  A lot of things don't work yet in Rails 3, so it's a work in progress.

Here's a quick thing I'm waiting for with Rails 3 (things that should be working flawlessly):

- Shoulda (too complicated and buggy now)
- Rails Cells (tried to get it working, too many problems with Rails 3)
- Awesome Nested Set (have a plugin somewhat working, but don't want to be using a plugin)

I don't yet know exactly how to create a Rails 3 compatible gem, so I haven't been converting gems to Rails 3 as I go.  Maybe I'll figure that out this week.

Other than that, it's pretty cool.

# Installation

    git clone http://github.com/viatropos/martini
    cd martini
    bundle install
    rake db:seed
    rake db:migrate
    rails server thin

# How it was made

    rails generate scaffold page title:string body:text description:text format:string published:boolean permalink:string allow_comments:boolean allow_pings:boolean
    rails generate scaffold post title:string body:text description:text format:string published:boolean permalink:string allow_comments:boolean allow_pings:boolean
    rails generate scaffold tag name:string
    rails generate scaffold category name:string description:text parent_id:integer
    rails generate scaffold asset title:string metadata:text data_file_name:string data_content_type:string data_file_size:string, data_updated_at:string assetable_type:string assetable_id:integer permalink:string
    rails generate scaffold quote user_id:integer body:text
    rails generate scaffold preferences name:string value:text
    
# Theme Support

The goal of controllers to me is to take a URI and find a set of data for the views.  Anything that has to do with the User Experience is left to the views (this includes the browser title, meta tags, and description, because you might want to say different things if it were a dark theme vs. a light theme).

So in each of your views you can/should define the following:

- title
- keywords
- description

### Todo

- Shoulda or RSpec (would prefer shoulda but it's been a nightmare so far)
- Need to figure out how hooks work
- Rails Cells will be used for widgets, once it's stable enough to use with Rails 3
- AuthlogicConnect integration
- Rails 3 Gem architecture
- Nested Dynamic Routes and Route Helpers

# Extractions

These libraries will be extracted out of the base

## Carpenter
    rails generate scaffold layout name:string has_many:areas
    rails generate scaffold area has_many:parts belongs_to:layout
    rails generate scaffold parts name:string description:text type:string

Uses [Rails Cells](http://cells.rubyforge.org/).  [Cells for Rails 3](http://cells.rubyforge.org/download.html), [Working Branch](http://github.com/mlomnicki/cells3/tree/integration).

- Each Page/Post has a Layout.
- Each Layout has a bunch of content Areas.
  - Sidebar, Content, Top, Bottom, Header, Footer, Logo, Navigation
- There can be unlimited number of Areas (tons of sidebars for example, with different Parts)
- Areas are composed of Parts (Cells, Widgets, Blocks, Portlets, whatever you call em).
- Parts define what to views to render, and what Cell to call.

## ActsAsConfigurable
    rails generate scaffold options name:string value:text description:string

Settings belong to a Configuration. (options, preferences...).  
  
## ActsAsAssetable

## ActsAsSyncable
    
## FrontPage
  Metadata helpers
  
## ActsAsCategorizable

Wordpress Database:
http://codex.wordpress.org/Database_Description
http://codex.wordpress.org/images/8/83/WP_27_dbsERD.png

Wordpress custom fields:
http://codex.wordpress.org/Custom_Fields

For Keywords
http://github.com/alexrabarts/term_extraction