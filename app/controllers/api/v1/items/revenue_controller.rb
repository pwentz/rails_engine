class Api::V1::Items::RevenueController < ApplicationController
  respond_to :json

  def index
    @items = Item.most_revenue(params[:quantity])

    respond_with @items
  end
end
