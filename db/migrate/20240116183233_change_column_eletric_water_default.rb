# frozen_string_literal: true

class ChangeColumnEletricWaterDefault < ActiveRecord::Migration[7.0]
  def change_table
    change_column_default :rooms, :electric_amount_new, 0
    change_column_default :rooms, :water_amout_new, 0
    change_column_default :rooms, :electric_amount_old, 0
    change_column_default :rooms, :water_amout_old, 0
  end
end
