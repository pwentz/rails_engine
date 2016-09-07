class Api::V1::Merchants::InvoicesController < Api::V1::BaseController
  def index
    invoices = Merchant.find(params[:id]).invoices

    respond_with invoices
  end
end
