# frozen_string_literal: true

class AddNameAddressPhonenumberToUsers < ActiveRecord::Migration[7.0]
  def change_table
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :address, :string, null: false, default: ''
    add_column :users, :phone_number, :string, null: false, default: ''
  end
end
