# frozen_string_literal: true

class AddDayToTimesheet < ActiveRecord::Migration[7.0]
  def change
    add_column :timesheets, :day, :date # This line adds a new column named day to the existing timesheets table. The ':date' specifies that the data type of this column will be 'date'. This column is intended to store date information.
  end
end
