# frozen_string_literal: true

class CreateTimesheets < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheets do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps # This line adds two automatically managed columns, created_at and updated_at, to the table. These columns are used to track when a record is created or updated. The timestamps method is a shorthand for adding these timestamp columns.
    end
  end
end
