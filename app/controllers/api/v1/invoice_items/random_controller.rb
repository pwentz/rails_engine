class Api::V1::InvoiceItems::RandomController < Api::V1::BaseController
  def show
    invoice_item = random(InvoiceItem)

    respond_with invoice_item
  end
end
