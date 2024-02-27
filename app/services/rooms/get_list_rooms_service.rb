# frozen_string_literal: true

module Rooms
  class GetListRoomsService < ApplicationService
    def initialize(rooms, params) # rubocop:disable Lint/MissingSuper
      @rooms = rooms
      @params = params
    end

    def call
      filter
      rooms
    end

    private

    attr_accessor :rooms, :params

    def filter
      @rooms = filter_by_name if params[:search].present?
      @rooms = filter_by_type if params[:selected_value].present?
      rooms
    end

    def filter_by_name
      rooms.search_by_name(params[:search])
    end

    def filter_by_type
      case params[:selected_value]
      when 'rented'
        rooms.rooms_rented
      when 'empty'
        rooms.rooms_empty
      else
        rooms
      end
    end
  end
end
