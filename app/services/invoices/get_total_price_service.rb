# frozen_string_literal: true

module Invoices
  class GetTotalPriceService < ApplicationService
    def initialize(room, user) # rubocop:disable Lint/MissingSuper
      @room = room
      @setting = user&.setting
    end

    def call
      total_price_data
    end

    private

    attr_accessor :room, :setting

    def total_price_data
      {
        total_electric_price:,
        total_water_price:,
        total_invoice_price:
      }
    end

    def total_invoice_price
      @total_invoice_price ||= room.price_room + total_electric_price + total_water_price + setting.price_internet + setting.price_security + setting.price_trash
    end

    def total_electric_price
      @total_electric_price ||= (room.electric_amount_new - room.electric_amount_old) * setting.price_electric
    end

    def total_water_price
      @total_water_price ||= (room.water_amout_new - room.water_amout_old) * setting.price_water
    end
  end
end
