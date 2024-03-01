# frozen_string_literal: true

module Renters
  class GetInfoRentersService < ApplicationService
    def initialize(renters) # rubocop:disable Lint/MissingSuper
      @renters = renters
    end

    def call
      info_data
    end

    private

    attr_accessor :renters

    def info_data
      {
        renter_total:,
        renter_main:,
        renter_member:
      }
    end

    def renter_total
      renters.size
    end

    def renter_main
      renters.renters_main.size
    end

    def renter_member
      renters.renters_member.size
    end
  end
end
