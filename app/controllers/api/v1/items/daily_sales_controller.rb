class Api::V1::Items::DailySalesController < Api::V1::BaseController
  def show
    @item = Item.find(params[:id])
  end
end
