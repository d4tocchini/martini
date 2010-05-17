class SiteSettings < Configuration
  
  # site
  preference :title, :string, :default => "Martini"
  preference :tagline, :string
  preference :email, :string
  preference :copyright, :string
  preference :timezone, :string
  preference :date_format, :string
  preference :time_format, :string
  preference :week_starts_on, :string
  preference :language, :string, :default => "en-US"
  preference :touch_enabled, :default => true
  preference :touch_as_subdomain, :default => false
  
end
