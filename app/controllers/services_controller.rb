# frozen_string_literal: true

class ServicesController < BaseController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  before_action :prepare_index, only: %i[index]
  before_action :set_service, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new
    @service = Service.new
  end

  def edit
    @service.price = format_to_vnd_not_unit(@service.price)
  end

  def create
    remove_decimal_separator(params[:service], %i[price])
    @service = current_user.services.new(service_params)
    render_result_action(@service.save, :new)
  end

  def update
    remove_decimal_separator(params[:service], %i[price])
    render_result_action(@service.update(service_params), :edit)
  end

  def destroy
    render_result_action(@service.really_destroy!, :destroy)
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price, :note)
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      params_hash[key] = params_hash[key].delete('.') if params_hash[key].present?
    end
  end

  def render_result_action(result, action, path = services_path, model = "Service: #{@service.name}")
    name = 'service_list'
    frame_back_name = 'new_service'
    render_result(result:, path:, model:, action:, name:, frame_back_name:)
  end

  def prepare_index
    current_user_with_services = User.includes(:services).find(current_user.id)
    @services = current_user_with_services.services
    @pagy, @services = pagy(@services, items: 9)
  end
end
