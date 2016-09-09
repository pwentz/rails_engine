class Api::V1::InvoiceItems::ItemsController < Api::V1::BaseController
  def show
    @item = InvoiceItem.find(params[:id]).item
    render 'api/v1/items/show'
  end
end
