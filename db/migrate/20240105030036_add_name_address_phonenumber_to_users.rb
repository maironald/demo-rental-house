# frozen_string_literal: true

class AddNameAddressPhonenumberToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :name, null: false, default: ''
      t.string :address, null: false, default: ''
      t.string :phone_number, null: false, default: ''
    end
  end
end
