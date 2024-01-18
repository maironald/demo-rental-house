# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy show_renters]
  before_action :authenticate_user!

  def index
    @rooms = Room.all
    @count_room_empty = current_user.rooms.where(renter_id: nil).count
    @count_room_rented = current_user.rooms.where.not(renter_id: nil).count
  end

  def show; end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: 'Room was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      redirect_to rooms_path, notice: 'Room was successfully edited.'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: 'Room was successfully deleted.'
  end

  def show_renters
    @renter_in_rooms = current_user.rooms.pluck(:renter_id).flatten.uniq
    @renters_not_in_room = current_user.renters.where.not(id: @renter_in_rooms)
  end

  def add_renter_to_room
    @renter_room = Room.where(id: params[:id]).update(renter_id: params[:room][:renter_id])
    return unless @renter_room

    redirect_to rooms_path, notice: 'You have just add renter to room successfully.'
  end

  def destroy_renter_from_room
    @renter = Room.where(id: params[:id]).update(renter_id: nil)
    return unless @renter

    redirect_to rooms_path, notice: 'You have just remove renter from room successfully.'
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :length, :width, :price_room, :limit_residents, :description, :electric_amount_new, :electric_amount_old, :water_amout_new, :water_amout_old, :service_ids)
  end
end
