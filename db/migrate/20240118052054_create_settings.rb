# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.decimal :price_water, default: 0
      t.decimal :price_electric, default: 0
      t.decimal :price_internet, default: 0
      t.decimal :price_trash, default: 0
      t.decimal :price_security, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
