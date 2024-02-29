# frozen_string_literal: true

module Invoices
  class GetListInvoicesService < ApplicationService
    def initialize(invoices, params) # rubocop:disable Lint/MissingSuper
      @invoices = invoices
      @params = params
    end

    def call
      filter
      invoices
    end

    private

    attr_accessor :invoices, :params

    def filter
      @invoices = filter_by_name if params[:search].present?
      @invoices = filter_by_type if params[:selected_value].present?
      invoices
    end

    def filter_by_name
      invoices.search_by_name(params[:search])
    end

    def filter_by_type
      case params[:selected_value]
      when 'unpaid'
        invoices.total_price_greater_than_paid_money
      when 'paid'
        invoices.total_price_equal_with_paid_money
      else
        invoices
      end
    end
  end
end
