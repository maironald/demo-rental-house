# frozen_string_literal: true

class AddUniqueIndexToRoomsName < ActiveRecord::Migration[7.0]
  def change
    add_index :rooms, %i[name user_id], unique: true
  end
end
