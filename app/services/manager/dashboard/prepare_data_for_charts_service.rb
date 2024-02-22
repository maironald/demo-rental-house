# frozen_string_literal: true

module Manager
  module Dashboard
    class PrepareDataForChartsService < ApplicationService
      def initialize(user)
        @rooms = user.rooms
        @services = user.services
        @invoices = user.invoices
      end

      def call
        {
          benefits_data:,
          rooms_data:
        }
      end

      private

      attr_accessor :rooms, :services, :invoices

      def benefits_data
        {
          benefits: benefit_for_month,
          expenses: expenditure_for_month,
          amount_info: {
            total_benefit_theory:,
            total_benefit_real:,
            total_expenditure:
          }
        }
      end

      def total_expenditure
        @total_expenditure ||= services.sum(&:price)
      end

      def total_benefit_real
        @total_benefit_real ||= invoices.sum(&:paid_money)
      end

      def total_benefit_theory
        @total_benefit_theory ||= invoices.sum(&:total_price)
      end

      def benefit_for_month
        group_calculate_invoice_price(:paid_money)
      end

      def expenditure_for_month
        group_calculate_invoice_price(:price)
      end

      def rooms_data
        total_rooms = rooms.size
        total_rented_rooms = rooms.rooms_rented.size
        total_empty_rooms = total_rooms - total_rented_rooms

        { total_amount_room: total_rented_rooms, amount_room_nil: total_empty_rooms }
      end

      def group_calculate_invoice_price(field)
        invoices.group_by { |invoice| invoice.created_at.month }.map do |month, invoices|
          [invoices.sum(&field), month]
        end&.flatten
      end
    end
  end
end
