class Api::V1::Customers::RandomController < Api::V1::BaseController
  def show
    customer = random(Customer)

    respond_with customer
  end
end
