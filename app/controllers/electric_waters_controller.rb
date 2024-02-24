# frozen_string_literal: true

class ElectricWatersController < BaseController
  include ApplicationHelper
  before_action :set_room, only: %i[edit update show_detail]

  def show
    @rooms = current_user.rooms.all
    @pagy, @rooms = pagy(@rooms, items: 9)
  end

  def new; end

  def edit; end

  def update
    respond_to do |format|
      if @room.update(electric_water_params)
        reload_electric_waters(format, type: :success, message: "You change the value of water and electric in room '#{@room.name}' successfully.")
      else
        render_errors(format, :edit)
      end
    end
  end

  def show_detail; end

  private

  def electric_water_params
    params.require(:room).permit(:electric_amount_old, :electric_amount_new, :water_amout_old, :water_amout_new)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reload_electric_waters(format, options = {})
    @rooms = current_user.rooms.all
    @pagy, @rooms = pagy(@rooms, items: 9)
    format.html { redirect_to electric_waters_path, notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('electric_water_list', partial: 'electric_waters/table', locals: { rooms: @rooms, pagy: @pagy }),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_electric_water', partial: 'electric_waters/form')] }
  end
end
