# frozen_string_literal: true

class RentersController < BaseController
  before_action :set_renter, only: %i[show edit update destroy]

  def index
    # get all the renters id who have rented a room through current user
    @room_ids = current_user.rooms.pluck(:id)
    @renters = if params[:search].present?
                 Renter.where('renters.name LIKE ? AND room_id IN (?)', "%#{params[:search]}%", @room_ids)
               else
                 Renter.where(room_id: @room_ids)
               end

    selected_value = params[:selected_value]
    if selected_value == 'main'
      @renters = @renters.where(renter_type: 'main')
    elsif selected_value == 'member'
      @renters = @renters.where(renter_type: 'member')
    else
      @renters
    end

    @pagy, @renters = pagy(@renters, items: 9)
  end

  def show; end

  def new
    @renter = Renter.new
  end

  def edit
    # @default_rooms = current_user.rooms.select { |room| room.renter_id.nil? }
  end

  def create
    @room = Room.find_by(id: params[:room_id])
    @renter = @room.renters.build(renter_params)
    # @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])

    # Find the main renter of the room to replace another new main renter in the same room.
    Renter.find_by(room_id: params[:room_id], renter_type: 'main')&.update(renter_type: 'member') if renter_params[:renter_type] == 'main'
    if @renter.save
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: 'Renter was successfully created.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('room-list', partial: 'rooms/table', locals: { room: @room }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])
    if @renter.update(renter_params)
      respond_to do |format|
        format.html { redirect_to renters_path, notice: 'Renter was successfully edited.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('renter-list', partial: 'renters/table', locals: { renter: @renter }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @renter.destroy
    respond_to do |format|
      format.html { redirect_to renters_path, notice: 'Renter was successfully deleted.' }
    end
  end

  def destroy_all
    Renter.destroy_all
    respond_to do |format|
      format.html { redirect_to renters_path, notice: 'Renter was successfully deleted all.' }
    end
  end

  def show_renters
    @renter_in_rooms = Renter.where(room_id: params[:room_id])
    @renter_main = Renter.find_by(room_id: params[:room_id], renter_type: 'main')
  end

  private

  def set_renter
    @renter = Renter.find(params[:id])
  end

  def renter_params
    params.require(:renter).permit(:name, :phone_number, :identity, :address, :gender, :renter_type, :deposit)
  end
end
