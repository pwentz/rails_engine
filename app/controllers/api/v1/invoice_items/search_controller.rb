class Api::V1::InvoiceItems::SearchController < Api::V1::BaseController
  before_action :format_unit_price

  def index
    invoice_items = InvoiceItem.where(invoice_item_params)

    respond_with invoice_items
  end

  def show
    invoice_item = InvoiceItem.find_by(invoice_item_params)

    respond_with invoice_item
  end

  private

  def invoice_item_params
    params.permit(
      :id,
      :item_id,
      :invoice_id,
      :quantity,
      :unit_price,
      :created_at,
      :updated_at
    )
  end

  def format_unit_price
    if invoice_item_params[:unit_price]
      unit_price = invoice_item_params[:unit_price]
    end

    if unit_price && unit_price.include?('.')
      params[:unit_price] = (unit_price.to_f * 100).round(0)
    end
  end
end
