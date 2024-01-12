# frozen_string_literal: true

class RoomsService < ApplicationRecord
  belongs_to :room
  belongs_to :service
end
