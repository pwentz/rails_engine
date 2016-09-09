class Api::V1::Items::ItemsSoldController < Api::V1::BaseController
  def index
    @items = Item.top_items_by_number_sold(params[:quantity])
    render 'api/v1/items/index'
  end
end
