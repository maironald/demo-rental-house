# frozen_string_literal: true

class AddDeletedAtToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :deleted_at, :datetime
    add_index :invoices, :deleted_at
  end
end
