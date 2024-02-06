# frozen_string_literal: true

module Users
  class DashboardController < BaseController
    def index
      @user = current_user
      amount_room_for_dashboard
      calculate_total_benefit_theory
      calculate_total_benefit_real
      calculate_total_expenditure
      benefit_for_month
      expenditure_for_month
      @data_benefit = {
        total_benefit_theory: @total_benefit_theory,
        total_benefit_real: @total_benefit_real,
        total_expenditure: @total_expenditure
      }
      @data_room = {
        total_amount_room: @total_amount_room,
        amount_room_nil: @amount_room_nil
      }
      @room_ids = Renter.distinct.pluck(:room_id)
      @rooms_nil = current_user.rooms.where.not(id: @room_ids)
      @invoices_not_pay = Invoice.where('paid_money < total_price AND room_id IN (?)', @room_ids)
    end

    private

    def calculate_total_expenditure
      @total_expenditure = 0
      current_user.services.each do |service|
        @total_expenditure += service.price
      end
    end

    def calculate_total_benefit_theory
      @total_benefit_theory = 0
      current_user.rooms.each do |room|
        Invoice.where(room_id: room.id).find_each do |invoice|
          @total_benefit_theory += invoice.total_price
        end
      end
    end

    def calculate_total_benefit_real
      @total_benefit_real = 0
      current_user.rooms.each do |room|
        Invoice.where(room_id: room.id).find_each do |invoice|
          @total_benefit_real += invoice.paid_money
        end
      end
    end

    def amount_room_for_dashboard
      @rooms = current_user.rooms.all
      @room_ids = Renter.distinct.pluck(:room_id)
      @total_amount_room = @rooms.where(id: @room_ids).count
      @amount_room_nil = @rooms.where.not(id: @room_ids).count
    end

    def benefit_for_month
      @room_ids_invoice = current_user.rooms.pluck(:id)
      @profit_by_month = Invoice
                         .select('EXTRACT(MONTH FROM created_at) as benefit_month, SUM(paid_money) as monthly_profit')
                         .where(room_id: @room_ids_invoice)
                         .group('benefit_month')
                         .order('benefit_month')
      @benefits = @profit_by_month.map { |record| [record['benefit_month'], record['monthly_profit']] }
    end

    def expenditure_for_month
      @expenses_by_month = current_user.services
                                       .select('EXTRACT(MONTH FROM created_at) as expense_month, SUM(price) as monthly_profit')
                                       .group('expense_month')
                                       .order('expense_month')
      @expenses = @expenses_by_month.map { |record| [record['expense_month'], record['monthly_profit']] }
    end
  end
end
