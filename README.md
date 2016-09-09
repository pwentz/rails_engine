# Rails Engine
[![Code Climate](https://codeclimate.com/github/pwentz/rails_engine/badges/gpa.svg)](https://codeclimate.com/github/pwentz/rails_engine) [![Stories in Ready](https://badge.waffle.io/pwentz/rails_engine.svg?label=ready&title=Ready)](http://waffle.io/pwentz/rails_engine)

Rails Engine is a Rails 5.0 API that serves up record, relationship, and business intelligence analysis data in JSON format. No authentication is required.

## Setup
* `bundle`
* `rails db:setup`
* `rake import` to seed the database

## Usage
* Open a local server with `rails s`
* All endpoints respond _only_ to `GET` requests

#### Record Endpoints
* **Categories**:
  * Customers
  * Merchants
  * Items
  * Invoices
  * Invoice Items
  * Transactions


* Each category responds to the following endpoints:
  * `/api/v1/<category_name>`
    * Return all customer records
  * `/api/v1/<category_name>/:id`
    * Return a single customer record
  * `/api/v1/<category_name>/random`
    * Return a random customer record
  * `/api/v1/<category_name>/find?`
    * Acceptable query parameters include `id`, `first_name`, and `last_name`
  * `/api/v1/<category_name>/find_all?`
    * Acceptable query parameters include `id`, `first_name`, and `last_name`

#### Relationship Endpoints
* **Merchants**
  * `/api/v1/merchants/:id/items`
    * returns a collection of items associated with that merchant
  * `/api/v1/merchants/:id/invoices`
    * returns a collection of invoices associated with that merchant from their known orders
* **Invoices**
  * `/api/v1/invoices/:id/transactions`
    * returns a collection of associated transactions
  * `/api/v1/invoices/:id/invoice_items`
    * returns a collection of associated invoice items
  * `/api/v1/invoices/:id/items`
    * returns a collection of associated items
  * `/api/v1/invoices/:id/customer`
    * returns the associated customer
  * `/api/v1/invoices/:id/merchant`
    * returns the associated merchant
* **Invoice Items**
  * `/api/v1/invoice_items/:id/invoice`
    * returns the associated invoice
  * `/api/v1/invoice_items/:id/item`
    * returns the associated item
* **Items**
  * `/api/v1/items/:id/invoice_items`
    * returns a collection of associated invoice items
  * `/api/v1/items/:id/merchant`
    * returns the associated merchant
* **Transactions**
  * `/api/v1/transactions/:id/invoice`
    * returns the associated invoice
* **Customers**
  * `/api/v1/customers/:id/invoices`
    * returns a collection of associated invoices
  * `/api/v1/customers/:id/transactions`
    * returns a collection of associated transactions

#### Business intelligence Endpoints
* **All Merchants**
  * GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  * GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
  * GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
    * _Assumes the dates provided match the format of a standard ActiveRecord timestamp._
* **Single Merchant**
  * `/api/v1/merchants/:id/revenue`
    * returns the total revenue for that merchant across all transactions
  * `/api/v1/merchants/:id/revenue?date=x`
    * returns the total revenue for that merchant for a specific invoice date _x_
  * `/api/v1/merchants/:id/favorite_customer`
    * returns the customer who has conducted the most total number of successful transactions
  * `/api/v1/merchants/:id/customers_with_pending_invoices`
    * returns a collection of customers which have pending (unpaid) invoices
* **Items**
  * `/api/v1/items/most_revenue?quantity=x`
    * returns the top _x_ items ranked by total revenue generated
  * `/api/v1/items/most_items?quantity=x`
    * returns the top _x_ item instances ranked by total number sold
  * `/api/v1/items/:id/best_day`
    * returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, the most recent day is returned.
* **Customers**
  * `/api/v1/customers/:id/favorite_merchant`
    * returns a merchant where the customer has conducted the most successful transactions

### Collaborators
* [Ryan Flach](http://www.github.com/ryanflach)
* [Pat Wentz](http://www.github.com/pwentz)
