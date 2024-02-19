# frozen_string_literal: true

class RemoveRenterIdFromRooms < ActiveRecord::Migration[7.0]
  def up
    remove_column :rooms, :renter_id
  end

  def down
    add_column :rooms, :renter_id, :bigint
  end
end
