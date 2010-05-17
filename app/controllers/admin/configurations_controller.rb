class Admin::ConfigurationsController < Admin::BaseController
  def update
    update!{ edit_admin_configuration_url(@configuration) }
  end
end
