class Api::V1::Customers::SearchController < Api::V1::BaseController
  def index
    @customers = Customer.where(customer_params)
    render 'api/v1/customers/index'
  end

  def show
    @customer = Customer.find_by(customer_params)
    render 'api/v1/customers/show'
  end

  private

  def customer_params
    params.permit(
      :id,
      :first_name,
      :last_name,
      :created_at,
      :updated_at
    )
  end
end
