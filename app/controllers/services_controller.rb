# frozen_string_literal: true

class ServicesController < BaseController
  before_action :set_service, only: %i[show edit update destroy]

  def index
    @services = current_user.services.order(created_at: :desc)
    @pagy, @services = pagy(@services, items: 4)
  end

  def show; end

  def new
    @service = Service.new
  end

  def edit; end

  def create
    @service = current_user.services.new(service_params)

    if @service.save
      format.html { redirect_to services_path, notice: 'Service was successfully created.' }
      format.turbo_stream do
        @pagy, @services = pagy(current_user.services.order(created_at: :desc), items: 5)

        render turbo_stream: [
          # turbo_stream.prepend("service-#{@service.id}", partial: 'services/service', locals: { service: @service }),
          turbo_stream.replace('service_list', partial: 'services/table')
          # turbo_stream.remove('remote_modal')
        ]
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_path, notice: 'Service was successfully updated.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.remove('remote_modal')]
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
