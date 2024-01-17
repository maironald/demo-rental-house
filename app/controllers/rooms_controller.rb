# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy show_renters show_all_services]
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
    @renter_in_rooms = current_user.rooms.all.pluck(:renter_id).flatten.uniq
    @renters_not_in_room = current_user.renters.where.not(id: @renter_in_rooms)
  end

  def add_renter_to_room
    @renter_room = Room.where(id: params[:id]).update(renter_id: params[:room][:renter_id])
    if(@renter_room)
      redirect_to rooms_path, notice: 'You have just add renter to room successfully.'
    end
  end

  def destroy_renter_from_room
    @renter = Room.where(id: params[:id]).update(renter_id: nil)
    if(@renter)
      redirect_to rooms_path, notice: 'You have just remove renter from room successfully.'
    end
  end

  def show_all_services
    @services = current_user.services.all
  end

  def add_services_to_room
    @room = Room.find(params[:id])
    RoomService.where(room_id: params[:id]).destroy_all
    if !params[:room].nil?
      @service_ids = params[:room][:service_ids]
      @service_ids.each do |id|
        @service = Service.find(id)
        @room.services << @service
        flash[:success] = 'Service added to room successfully.'
      end
    else
      flash[:notice] = 'Please select at least one service.'
    end
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :length, :width, :price_room, :limit_residents, :description,:electric_amount_new, :electric_amount_old, :water_amout_new, :water_amout_old, :service_ids)
  end
end
