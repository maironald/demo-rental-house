# frozen_string_literal: true

class RemovePrecisionAndScaleFromInvoicesColumns < ActiveRecord::Migration[7.0]
  def up
    change_table :invoices, bulk: true do |t|
      t.change :total_price, :decimal, default: 0, precision: nil, scale: nil
      t.change :paid_money, :decimal, default: 0, precision: nil, scale: nil
    end
  end

  def down
    change_table :invoices, bulk: true do |t|
      t.change :total_price, :decimal, default: 0, precision: 10, scale: 2
      t.change :paid_money, :decimal, default: 0, precision: 10, scale: 2
    end
  end
end
