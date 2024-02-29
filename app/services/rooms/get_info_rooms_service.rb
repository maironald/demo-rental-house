# frozen_string_literal: true

module Rooms
  class GetInfoRoomsService < ApplicationService
    def initialize(room) # rubocop:disable Lint/MissingSuper
      @room = room
    end

    def call
      info_data
    end

    private

    attr_accessor :room

    def info_data
      {
        room_total:,
        room_used:,
        room_left:
      }
    end

    def room_total
      room.size
    end

    def room_used
      room.rooms_rented.size
    end

    def room_left
      room_total - room_used
    end
  end
end
