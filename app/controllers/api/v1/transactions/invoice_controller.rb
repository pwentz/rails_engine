class Api::V1::Transactions::InvoiceController < Api::V1::BaseController
  def show
    invoice = Transaction.find(params[:id]).invoice

    respond_with invoice
  end
end
