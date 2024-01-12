# frozen_string_literal: true

class CreateServicesAndRoomServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.bigint :price_service
      t.text :note

      t.timestamps
    end

    create_table(:rooms_services, id: false) do |t|
      t.references :room
      t.references :service
    end
  end
end
