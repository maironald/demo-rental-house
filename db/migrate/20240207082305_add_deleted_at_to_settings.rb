# frozen_string_literal: true

class AddDeletedAtToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :deleted_at, :datetime
    add_index :settings, :deleted_at
  end
end
