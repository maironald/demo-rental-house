# frozen_string_literal: true

class ChangeColumnStatusToString < ActiveRecord::Migration[7.0]
  def up
    change_column :renters, :status, :string
  end
end
