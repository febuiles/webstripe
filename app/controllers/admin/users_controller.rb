class Admin::UsersController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :admin_only
  before_filter :load_stripes

  def index
    @users = User.all
  end

  def invite
    User.invite!(email: params[:email])
    redirect_to admin_users_path, notice: "Invitation has been sent"
  end
end
