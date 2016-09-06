class Api::V1::Invoices::MerchantsController < Api::V1::BaseController
  def show
    merchant = Invoice.find(params[:id]).merchant

    respond_with merchant
  end
end
