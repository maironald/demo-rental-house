# frozen_string_literal: true

class AddColumnReferencesUserInService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :user_id, :bigint, null: false, foreign_key: true
  end
end
