# frozen_string_literal: true

module Rooms
  class GetInfoRoomsService < ApplicationService
    def initialize(rooms) # rubocop:disable Lint/MissingSuper
      @rooms = rooms
    end

    def call
      info_data
    end

    private

    attr_accessor :rooms

    def info_data
      {
        room_total:,
        room_used:,
        room_left:
      }
    end

    def room_total
      rooms.size
    end

    def room_used
      rooms.rooms_rented.size
    end

    def room_left
      room_total - room_used
    end
  end
end
