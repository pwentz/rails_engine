class Api::V1::Items::MostItemsController < Api::V1::BaseController
  def index
    top_items = Item.top_items_by_number_sold(quantity)

    respond_with top_items
  end
end
