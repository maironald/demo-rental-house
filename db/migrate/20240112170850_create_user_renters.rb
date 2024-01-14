# frozen_string_literal: true

class CreateUserRenters < ActiveRecord::Migration[7.0]
  def change
    create_table :user_renters do |t|
      t.belongs_to :user
      t.belongs_to :renter

      t.timestamps
    end
  end
end
