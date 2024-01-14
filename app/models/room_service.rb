# frozen_string_literal: true

# == Schema Information
#
# Table name: room_services
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint
#  service_id :bigint
#
# Indexes
#
#  index_room_services_on_room_id     (room_id)
#  index_room_services_on_service_id  (service_id)
#
class RoomService < ApplicationRecord
  belongs_to :room
  belongs_to :service
end
