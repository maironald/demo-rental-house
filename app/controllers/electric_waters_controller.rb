# frozen_string_literal: true

class ElectricWatersController < ApplicationController
  before_action :authenticate_user!

  def show
    @rooms = Room.all
  end

  def new; end

  def edit
    @electric_price = current_user.setting.price_electric
    @water_price = current_user.setting.price_water
  end

  def update
    if current_user.setting.update(electric_water_params)
      respond_to do |format|
        format.html { redirect_to electric_waters_path, notice: 'You change the value of water and electric successfully.' }
      end
    else
      render :edit
    end
  end

  private

  def electric_water_params
    params.require(:setting).permit(:price_electric, :price_water, :price_security, :price_internet, :price_trash)
  end
end
