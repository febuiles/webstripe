class StripesController < ApplicationController
  layout "admin"
  before_filter :load_stripes, :only => [:new, :index, :edit, :show]

  def index
  end

  def show
    @stripe = Stripe.find(params[:id])
  end

  def new
    @stripe = Stripe.new
  end

  def create
    @stripe = Stripe.new(params[:stripe])
    if @stripe.save
      redirect_to stripe_path(@stripe), :notice => "Your stripe has been created."
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
    redirect_to stripes_path
  end

  private

  def load_stripes
    @stripes = Stripe.all
  end
end
