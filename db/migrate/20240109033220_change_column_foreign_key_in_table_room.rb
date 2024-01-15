# frozen_string_literal: true

class ChangeColumnForeignKeyInTableRoom < ActiveRecord::Migration[7.0]
  def change_table
    change_column :rooms, :user_id, :bigint, null: false, foreign_key: true
    change_column :rooms, :renter_id, :bigint, null: false, foreign_key: true
  end
end
