class StripesController < ApplicationController
  def index
    @alignment = "horizontal"
  end

  def show
    @stripe = Stripe.find(params[:id])
    not_found unless @stripe
  end
end
