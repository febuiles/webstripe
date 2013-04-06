class Admin::StripeItemsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @stripe_items = StripeItem.all

    respond_to do |format|
      format.html
      format.json { render json: @stripe_items }
    end
  end

  def show
    @stripe_item = StripeItem.new

    respond_to do |format|
      format.html
      format.json { render json: @stripe_item }
    end
  end

  def create
    @stripe_item = StripeItem.new(params[:stripe_item])

    respond_to do |format|
      if @stripe_item.save
        format.json { render json: @stripe_item, status: :created }
      else
        format.json { render json: @stripe_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @stripe_item = StripeItem.find(params[:id])

    respond_to do |format|
      if @stripe_item.update_attributes(params[:stripe_item])
        format.json { render json: @stripe_item }
        # format.json { head :no_content, json: @stripe_item }
      else
        format.json { render json: @stripe_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stripe_item = StripeItem.find(params[:id])
    @stripe_item.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
