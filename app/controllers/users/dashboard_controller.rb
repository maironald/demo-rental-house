# frozen_string_literal: true

module Users
  class DashboardController < BaseController
    before_action :prepare_index, only: %i[index]

    def index; end

    private

    def prepare_index
      data_charts = Users::Dashboard::PrepareDataForChartsService.call(current_user)
      data_tables = Users::Dashboard::PrepareDataForTablesService.call(current_user)

      @data_benefit = data_charts.dig(:benefits_data, :amount_info)
      @data_room = data_charts[:rooms_data]
      @benefits = data_charts.dig(:benefits_data, :benefits)
      @expenses = data_charts.dig(:benefits_data, :expenses)
      @rooms = current_user.rooms
      @rooms_nil = data_tables[:rooms_empty]
      @invoices_not_pay = data_tables[:invoices_not_paid]
    end
  end
end
