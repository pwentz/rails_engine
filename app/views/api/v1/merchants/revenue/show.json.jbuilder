json.extract! @merchant
if params[:date]
  json.revenue to_price(@merchant.revenue_on_date(formatted_date))
else
  json.revenue to_price(@merchant.revenue)
end
