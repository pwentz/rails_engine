class Api::V1::Items::ItemsSoldController < Api::V1::BaseController
  def index
    top_items = Item.top_items_by_number_sold(params[:quantity])

    respond_with top_items
  end
end
