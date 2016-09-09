class Api::V1::Items::SearchController < Api::V1::BaseController
  before_action :format_unit_price_param

  def index
    @items = Item.where(item_params)
    render 'api/v1/items/index'
  end

  def show
    @item = Item.find_by(item_params)
    render 'api/v1/items/show'
  end

  private

  def item_params
    params.permit(
      :id,
      :name,
      :description,
      :unit_price,
      :merchant_id,
      :created_at,
      :updated_at
    )
  end
end
