class Api::V1::Items::SearchController < Api::V1::BaseController
  before_action :format_unit_price

  def index
    items = Item.where(item_params)

    respond_with items
  end

  def show
    item = Item.find_by(item_params)

    respond_with item
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

  def format_unit_price
    unit_price = item_params[:unit_price] if item_params[:unit_price]
    if unit_price && unit_price.include?('.')
      params[:unit_price] = (unit_price.to_f * 100).round(0)
    elsif unit_price
      params[:unit_price] = unit_price.to_i * 100
    end
  end
end
