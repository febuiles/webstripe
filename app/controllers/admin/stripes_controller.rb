class Admin::StripesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :load_stripes
  before_filter :remove_user, only: [:create, :update]

  respond_to :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: @stripes }
    end
  end

  def show
    @stripe = current_user.stripes.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @stripe }
    end
  end

  def new
    @stripe = current_user.stripes.create(state: "unpublished")
  end

  def create
    @stripe = current_user.stripes.build(params[:stripe])
    respond_to do |format|
      if @stripe.save
        format.json { render json: @stripe, status: :created }
      else
        format.json { render json: @stripe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    if current_user.admin?
      @stripe = Stripe.find(params[:id])
    else
      @stripe = current_user.stripes.find(params[:id])
    end

  end

  def update
    @stripe = Stripe.find(params[:id])
    old_status = @stripe.state
    respond_to do |format|
      if @stripe.update_attributes(params[:stripe])
        # send the mail notification if it was just published
        NotificationsMailer.new_stripe(@stripe).deliver if @stripe.state != old_status
        format.html { redirect_to admin_stripe_path(@stripe), :notice => "Your stripe has been updated." }
        format.json { render json: @stripe }
      else
        format.html { render :edit }
        format.json { render json: @stripe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stripe = current_user.stripes.find(params[:id])
    @stripe.destroy

    respond_to do |format|
      format.html { redirect_to admin_stripes_path }
      format.json { head :no_content }
    end
  end

  private

  def load_stripes
    @stripes = current_user.stripes
  end

  def remove_user
    params[:stripe].delete :user
  end
end
