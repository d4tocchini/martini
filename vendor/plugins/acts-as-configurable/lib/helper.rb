module ActsAsConfigurable::Helper
  def c(configuration, setting = nil)
    ActsAsConfigurable.get(configuration, setting)
  end
end

ActionView::Base.send(:include, ActsAsConfigurable::Helper)