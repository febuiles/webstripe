class StripesController < ApplicationController
  before_filter :set_access_control_headers, only: [:show]

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = 'GET'
  end

  def index
    @alignment = "horizontal"
  end

  def show
    @stripe = Stripe.find(params[:id])
    not_found unless @stripe
  end
end
