class Api::V1::Transactions::SearchController < Api::V1::BaseController
  def index
    @transactions = Transaction.where(transaction_params)
    render 'api/v1/transactions/index'
  end

  def show
    @transaction = Transaction.find_by(transaction_params)
    render 'api/v1/transactions/show'
  end

  private

  def transaction_params
    params.permit(
      :id,
      :invoice_id,
      :credit_card_number,
      :result,
      :created_at,
      :updated_at
    )
  end
end
