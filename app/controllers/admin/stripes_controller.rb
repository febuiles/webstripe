class Admin::StripesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :load_stripes

  def index
  end

  def show
    @stripe = current_user.stripes.find(params[:id])
  end

  def new
    @stripe = Stripe.new
  end

  def create
    @stripe = current_user.stripes.build(params[:stripe])
    if @stripe.save
      redirect_to admin_stripe_path(@stripe), :notice => "Your stripe has been created."
    else
      render :new
    end
  end

  def edit
    @stripe = current_user.stripes.find(params[:id])
  end

  def update
    @stripe = Stripe.find(params[:id])
    if @stripe.update_attributes(params[:stripe])
      redirect_to admin_stripe_path(@stripe), :notice => "Your stripe has been updated."
    else
      render :edit
    end
  end

  def destroy
    @stripe = current_user.stripes.find(params[:id])
    @stripe.destroy
    redirect_to admin_stripes_path
  end

  private

  def load_stripes
    @stripes = current_user.stripes
  end
end
