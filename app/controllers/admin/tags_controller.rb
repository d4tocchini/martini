class Admin::TagsController < Admin::BaseController
  def extract
    render :text => Tag.extract(params[:context])
  end
end
