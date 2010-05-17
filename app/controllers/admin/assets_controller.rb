class Admin::AssetsController < Admin::BaseController
  def update
    update!{ admin_assets_url }
  end
end
