# frozen_string_literal: true

class AddDeletedAtToRenters < ActiveRecord::Migration[7.0]
  def change
    add_column :renters, :deleted_at, :datetime
    add_index :renters, :deleted_at
  end
end
