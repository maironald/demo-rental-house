# frozen_string_literal: true

class ChangeAttrServicesAndRoomServices < ActiveRecord::Migration[7.0]
  def change_table
    change_column :rooms_services, :room_id, :bigint, null: false, foreign_key: true
    change_column :rooms_services, :service_id, :bigint, null: false, foreign_key: true
  end
end
