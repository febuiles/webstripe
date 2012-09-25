class Admin::StripesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :load_stripes, :only => [:new, :index, :edit, :show, :create]

  def index
  end

  def show
    @stripe = Stripe.find(params[:id])
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
    @stripe = Stripe.find(params[:id])
  end

  def update
  end

  def destroy
    @stripe = Stripe.find(params[:id])
    @stripe.destroy
    redirect_to admin_stripes_path
  end

  private

  def load_stripes
    @stripes = Stripe.all
  end
end
