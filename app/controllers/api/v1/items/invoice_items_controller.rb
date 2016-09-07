class Api::V1::Items::InvoiceItemsController < Api::V1::BaseController
  def index
    invoice_items = Item.find(params[:id]).invoice_items

    respond_with invoice_items
  end
end
