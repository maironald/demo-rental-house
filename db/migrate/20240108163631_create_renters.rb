# frozen_string_literal: true

class CreateRenters < ActiveRecord::Migration[7.0]
  def change
    create_table :renters do |t|
      t.string :name
      t.string :phone_number
      t.string :identity
      t.string :address
      t.string :gender, default: false, null: false
      t.integer :status
      t.bigint :deposit

      t.timestamps
    end
  end
end
