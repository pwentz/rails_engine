class Api::V1::Merchants::ItemsController < Api::V1::BaseController
  def index
    items = Merchant.find(params[:id]).items

    respond_with items
  end
end
