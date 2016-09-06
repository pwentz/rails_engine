class Api::V1::Merchants::ItemsController < ApplicationController
  respond_to :json
  def index
    items_sold = Merchant.most_items_sold(params[:quantity])
    respond_with items_sold
  end
end
