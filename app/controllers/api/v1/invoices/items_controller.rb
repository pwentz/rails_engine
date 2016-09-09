class Api::V1::Invoices::ItemsController < Api::V1::BaseController
  def index
    @items = Invoice.find(params[:id]).items
    render 'api/v1/items/index'
  end
end
