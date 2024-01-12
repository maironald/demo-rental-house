# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = Room.all
  end

  def show; end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to users_rooms_path, notice: 'Room was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      format.html { redirect_to users_rooms_path, notice: 'Room was successfully edited.' }
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    format.html { redirect_to users_rooms_path, notice: 'Room was successfully deleted.' }
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :length, :width, :price_room, :limit_residents, :description)
  end
end
