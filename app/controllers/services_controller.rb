# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]

  def index
    @services = Service.all
  end

  def show; end

  def new
    @service = Service.new
  end

  def edit; end

  def create
    @service = Service.new(service_params)
    if @service.save
      format.html { redirect_to users_services_path, notice: 'Service was successfully created.' }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      respond_to do |format|
        format.html { redirect_to users_services_path, notice: 'Service was successfully edited.' }
      end
    else
      render :edit
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    respond_to do |format|
      format.html { redirect_to users_services_path, notice: 'Service was successfully deleted.' }
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price_service, :note)
  end
end
