# frozen_string_literal: true

module Renters
  class GetListRentersService < ApplicationService
    def initialize(renters, params) # rubocop:disable Lint/MissingSuper
      @renters = renters
      @params = params
    end

    def call
      filter
      renters
    end

    private

    attr_accessor :renters, :params

    def filter
      @renters = filter_by_name if params[:search].present?
      @renters = filter_by_type if params[:selected_value].present?
      renters
    end

    def filter_by_name
      renters.search_by_name(params[:search])
    end

    def filter_by_type
      case params[:selected_value]
      when 'main'
        renters.renters_main
      when 'member'
        renters.renters_member
      else
        renters
      end
    end
  end
end
