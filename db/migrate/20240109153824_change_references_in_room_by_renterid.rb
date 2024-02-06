# frozen_string_literal: true

class ChangeReferencesInRoomByRenterid < ActiveRecord::Migration[7.0]
  def change_table
    change_column :rooms, :renter_id, :bigint, null: true, foreign_key: true
  end
end
