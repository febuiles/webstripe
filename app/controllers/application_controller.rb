class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    admin_stripes_path
  end

  private

  def admin_only
    redirect_to admin_stripes_path unless current_user.admin?
  end

  def load_stripes
    @stripes = current_user.stripes
  end
end
