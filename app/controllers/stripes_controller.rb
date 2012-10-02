class StripesController < ApplicationController
  def index
    @alignment = "horizontal"
  end

  def show
    @stripe = Stripe.find(params[:id])
    @alignment = "vertical"
  end
end
