# frozen_string_literal: true

class ServicesController < BaseController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  before_action :set_service, only: %i[show edit update destroy]

  def index
    current_user_with_services = User.includes(:services).find(current_user.id)
    @services = current_user_with_services.services
    @pagy, @services = pagy(@services, items: 9)
  end

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
    respond_to do |format|
      if @service.save
        reload_services_with_pagination(format, type: :success, message: "The service '#{@service.name}' was successfully created.")
      else
        render_errors(format, :new)
      end
    end
  end

  def update
    remove_decimal_separator(params[:service], %i[price])
    respond_to do |format|
      if @service.update(service_params)
        reload_services_with_pagination(format, type: :success, message: "The service '#{@service.name}' was successfully edited.")
      else
        render_errors(format, :edit)
      end
    end
  end

  def destroy
    @service.really_destroy!
    respond_to do |format|
      reload_services_with_pagination(format, type: :success, message: "The service '#{@service.name}' was successfully deleted.")
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price, :note)
  end

  def reload_services_with_pagination(format, options = {})
    current_user_with_services = User.includes(:services).find(current_user.id)
    @services = current_user_with_services.services
    @pagy, @services = pagy(@services, items: 9)
    format.html { redirect_to services_path, notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('service_list', partial: 'services/table', locals: { services: current_user.services.all, pagy: @pagy }),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_service', partial: 'services/form')] }
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      params_hash[key] = params_hash[key].delete('.')
    end
  end
end
