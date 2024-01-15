# frozen_string_literal: true

class CreateRoomServices < ActiveRecord::Migration[7.0]
  def change
    create_table :room_services do |t|
      t.belongs_to :room
      t.belongs_to :service

      t.timestamps
    end
  end
end
