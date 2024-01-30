# frozen_string_literal: true

class ChangeNameColumnType < ActiveRecord::Migration[7.0]
  def change
    rename_column :renters, :type, :renter_type
  end
end
