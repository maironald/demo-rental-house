# frozen_string_literal: true

class AddDeletedAtToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :deleted_at, :datetime
    add_index :services, :deleted_at
  end
end
