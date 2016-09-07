class Api::V1::InvoiceItems::InvoicesController < Api::V1::BaseController
  def show
    invoice = InvoiceItem.find(params[:id]).invoice

    respond_with invoice
  end
end
