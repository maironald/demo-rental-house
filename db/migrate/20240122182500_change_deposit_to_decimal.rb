# frozen_string_literal: true

class ChangeDepositToDecimal < ActiveRecord::Migration[7.0]
  def up
    change_column :renters, :deposit, :decimal
  end

  def down
    change_column :renters, :deposit, :bignit
  end
end
