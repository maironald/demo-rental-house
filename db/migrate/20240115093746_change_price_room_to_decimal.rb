# frozen_string_literal: true

class ChangePriceRoomToDecimal < ActiveRecord::Migration[7.0]
  def change_table
    change_column :rooms, :price_room, :decimal
  end
end
