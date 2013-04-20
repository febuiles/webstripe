class Admin::UsersController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :admin_only
  before_filter :load_stripes

  def index
    @users = User.order(:id)
  end

  def invite
    User.invite!(email: params[:email])
    redirect_to admin_users_path, notice: "Invitation has been sent"
  end

  def update
    @user = User.find params[:id]

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@user) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@user) }
      end
    end
  end
end
