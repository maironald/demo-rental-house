# frozen_string_literal: true

class AddColumnPriceOfWaterElectricToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :electric_price, :decimal, default: 1000, null: false
    add_column :users, :water_price, :decimal, default: 1000,  null: false
  end
end
