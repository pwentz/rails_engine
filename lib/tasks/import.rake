require 'csv'

desc "Import data from csv files"
task import: [:environment] do
  customers = 'db/customers.csv'
  invoice_items = 'db/invoice_items.csv'
  invoices = 'db/invoices.csv'
  items = 'db/items.csv'
  merchants = 'db/merchants.csv'
  transactions = 'db/transactions.csv'

  CSV.foreach(customers, headers: true) do |row|
    Customer.create!(
      first_name: row[1],
      last_name: row[2],
      created_at: row[3],
      updated_at: row[4]
    )
    puts "Created customer from row #{row}"
  end

  CSV.foreach(merchants, headers: true) do |row|
    Merchant.create!(
      name: row[1],
      created_at: row[2],
      updated_at: row[3]
    )
    puts "Created merchant from row #{row}"
  end

  CSV.foreach(invoices, headers: true) do |row|
    Invoice.create!(
      customer_id: row[1],
      merchant_id: row[2],
      status: row[3],
      created_at: row[4],
      updated_at: row[5]
    )
    puts "Created invoice from row #{row}"
  end

  CSV.foreach(transactions, headers: true) do |row|
    Transaction.create!(
      invoice_id: row[1],
      credit_card_number: row[2],
      credit_card_expiration_date: row[3],
      result: row[4],
      created_at: row[5],
      updated_at: row[6]
    )
    puts "Created transaction from row #{row}"
  end

  CSV.foreach(items, headers: true) do |row|
    Item.create!(
      name: row[1],
      description: row[2],
      unit_price: row[3],
      merchant_id: row[4],
      created_at: row[5],
      updated_at: row[6]
    )
    puts "Created item from row #{row}"
  end

  CSV.foreach(invoice_items, headers: true) do |row|
    InvoiceItem.create!(
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: row[4],
      created_at: row[5],
      updated_at: row[6]
    )
    puts "Created invoice item from row #{row}"
  end
end
