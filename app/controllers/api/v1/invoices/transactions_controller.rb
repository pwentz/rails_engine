class Api::V1::Invoices::TransactionsController < Api::V1::BaseController
  def index
    @transactions = Invoice.find(params[:id]).transactions
    render 'api/v1/transactions/index'
  end
end
