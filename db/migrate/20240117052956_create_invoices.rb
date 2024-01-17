# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :name
      t.decimal :total_price, default: 0, precision: 10, scale: 2
      t.decimal :paid_money, default: 0, precision: 10, scale: 2
      t.references :room

      t.timestamps
    end
  end
end
