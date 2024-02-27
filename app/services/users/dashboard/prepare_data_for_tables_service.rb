# frozen_string_literal: true

module Users
  module Dashboard
    class PrepareDataForTablesService < ApplicationService
      def initialize(user) # rubocop:disable Lint/MissingSuper
        @rooms = user.rooms
        @invoices = user.invoices
      end

      def call
        {
          rooms_empty:,
          invoices_not_paid:
        }
      end

      private

      attr_accessor :rooms, :invoices

      def rooms_empty
        rooms.rooms_empty
      end

      def invoices_not_paid
        invoices.total_price_greater_than_paid_money
      end
    end
  end
end
