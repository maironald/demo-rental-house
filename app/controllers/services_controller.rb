# frozen_string_literal: true

class ServicesController < BaseController
  before_action :set_service, only: %i[show edit update destroy]

  def index
    @services = current_user.services.all
    @pagy, @services = pagy(@services, items: 9)
  end

  def show; end

  def new
    @service = Service.new
  end

  def edit; end

  def create
    @service = current_user.services.build(service_params)
    if @service.save
      respond_to do |format|
        format.html { redirect_to services_path, notice: 'Service was successfully created.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('service-list', partial: 'services/table', locals: { service: @service }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      respond_to do |format|
        format.html { redirect_to services_path, notice: 'Service was successfully created.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('service-list', partial: 'services/table', locals: { service: @service }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
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
