# frozen_string_literal: true

class ElectricWatersController < BaseController
  before_action :set_room, only: %i[edit update]

  def show
    @rooms = current_user.rooms
  end

  def new; end

  def edit; end

  def update
    if @room.update(electric_water_params)
      respond_to do |format|
        format.html { redirect_to electric_waters_path, notice: 'You change the value of water and electric successfully.' }
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('amount-list', partial: 'electric_waters/table', locals: { rooms: @rooms }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def electric_water_params
    params.require(:room).permit(:electric_amount_old, :electric_amount_new, :water_amout_old, :water_amout_new)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
