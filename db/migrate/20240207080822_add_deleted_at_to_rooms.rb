# frozen_string_literal: true

class AddDeletedAtToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :deleted_at, :datetime
    add_index :rooms, :deleted_at
  end
end
