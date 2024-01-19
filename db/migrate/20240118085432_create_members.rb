# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :phone_number
      t.string :identity
      t.string :gender, default: false, null: false
      t.string :relation
      t.references :renter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
