class Admin::StripesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :load_stripes

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
        NotificationsMailer.new_stripe(@stripe).deliver
        format.json { render json: @stripe, status: :created }
      else
        format.json { render json: @stripe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @stripe = current_user.stripes.find(params[:id])
  end

  def update
    @stripe = Stripe.find(params[:id])

    respond_to do |format|
      if @stripe.update_attributes(params[:stripe])
        format.html { redirect_to admin_stripe_path(@stripe), :notice => "Your stripe has been updated." }
        format.json { render json: { redirect: admin_stripes_path } }
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
end
