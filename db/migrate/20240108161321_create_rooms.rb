# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table (:rooms) do |t|
      t.string :name
      t.integer :length
      t.integer :width
      t.bigint :price_room
      t.datetime :rental_speriod
      t.integer :electric_amount_old
      t.integer :electric_amount_new
      t.integer :water_amout_old
      t.integer :water_amout_new
      t.integer :limit_residents
      t.text :description
      t.references :user
      t.references :renter
      t.timestamps
    end
  end
end
