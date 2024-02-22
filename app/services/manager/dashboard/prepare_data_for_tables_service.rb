# frozen_string_literal: true

module Manager
  module Dashboard
    class PrepareDataForTablesService < ApplicationService
      def initialize(user)
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
        invoices.not_paid
      end
    end
  end
end
