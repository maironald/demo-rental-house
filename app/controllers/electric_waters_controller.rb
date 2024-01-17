
class ElectricWatersController < ApplicationController
  before_action :authenticate_user!

  def show
    @rooms = Room.all
  end

  def new; end
  def edit
    @electric_price = current_user.electric_price
    @water_price = current_user.water_price
  end

  def update
    if current_user.update(electric_water_params)
      respond_to do |format|
        format.html { redirect_to electric_waters_path, notice: "You change the value of water and electric successfully." }
      end
    else
      render :edit
    end
  end

  private

  def electric_water_params
    params.require(:user).permit(:electric_price, :water_price)
  end
end
