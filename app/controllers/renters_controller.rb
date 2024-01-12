# frozen_string_literal: true

class RentersController < ApplicationController
  before_action :set_renter, only: %i[show edit update destroy]

  def index
    # get all the renters id who have rented a room by current user
    @renter_id = current_user.rooms.pluck(:renter_id)
    @renters = Renter.where(id: @renter_id)
  end

  def show; end

  def new
    @renter = Renter.new
    @renter.rooms.build
    @default_rooms = current_user.rooms.select { |room| room.renter_id.nil? }
  end

  def edit
    @default_rooms = current_user.rooms.select { |room| room.renter_id.nil? }
  end

  def create
    @renter = Renter.new(mapped_renter_params)
    @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])

    if @renter.save
      Room.where(id: @room_info.id).update(renter_id: @renter.id)
      respond_to do |format|
        format.html { redirect_to users_renters_path, notice: 'Renter was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @renter = Renter.find(params[:id])
    @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])
    if @renter.update(mapped_renter_params)
      if @room_info.nil?
        respond_to do |format|
          format.html { redirect_to users_renters_path, notice: "Renter was successfully edited but You didn't change the room." }
        end
      else
        Room.where(renter_id: params[:id]).update(renter_id: nil)
        Room.where(id: @room_info.id).update(renter_id: params[:id])
      end
      format.html { redirect_to users_renters_path, notice: 'Renter was successfully edited.' }
    else
      render :edit
    end
  end

  def destroy
    @renter = Renter.find(params[:id])
    Room.where(renter_id: params[:id]).update(renter_id: nil)
    @renter.destroy
    respond_to do |format|
      format.html { redirect_to users_renters_path, notice: 'Renter was successfully deleted.' }
    end
  end

  private

  def set_renter
    @renter = Renter.find(params[:id])
  end

  def renter_params
    params.require(:renter).permit(:name, :phone_number, :identity, :address, :gender, :status, :deposit, rooms_attributes: %i[id name _destroy default_room_id])
  end

  # Get only the selected keys
  def mapped_renter_params
    # The * (splat) operator is used to pass the elements of the selected_keys array as individual arguments to slice.
    selected_keys = %i[name phone_number identity address gender status deposit] # Add other keys as needed
    renter_params.to_h.slice(*selected_keys)
  end
end
