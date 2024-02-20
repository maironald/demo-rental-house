# frozen_string_literal: true

class ServicesController < BaseController
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

  def edit; end

  def create
    @service = current_user.services.build(service_params)
    respond_to do |format|
      if @service.save
        format.html { redirect_to services_path, notice: 'Service was successfully created.' }
        format.turbo_stream do
          render turbo_stream: [
            # turbo_stream.replace('new_service', partial: 'services/form', locals: { service: Service.new })
            # Turbo.visit(services_path, 'service-list')
            turbo_stream.replace('service_list', partial: 'services/list', locals: { services: current_user.services })
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('new_service', partial: 'services/form')
          ], status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_path, notice: 'Service was successfully updated.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.remove('my_modal_4')]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('new_service', partial: 'services/form')
          ], status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @service.really_destroy!
    respond_to do |format|
      format.html { redirect_to services_path, notice: 'Service was successfully deleted.' }
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price, :note)
  end
end
