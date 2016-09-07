class Api::V1::Merchants::ItemsAnalysisController < Api::V1::BaseController
  def index
    items_sold = Merchant.most_items_sold(params[:quantity])
    respond_with items_sold
  end
end
