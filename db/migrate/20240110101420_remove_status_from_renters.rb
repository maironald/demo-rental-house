# frozen_string_literal: true

class RemoveStatusFromRenters < ActiveRecord::Migration[7.0]
  def change
    remove_column :renters, :status, :string
  end
end
