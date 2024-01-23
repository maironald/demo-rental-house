# frozen_string_literal: true

class RentersController < ApplicationController
  before_action :set_renter, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    # get all the renters id who have rented a room through current user
    @renters = Renter.all
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
    Renter.find_by(room_id: params[:room_id], renter_type: 'main')&.update(renter_type: 'member')
    if @renter.save
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: 'Renter was successfully created.' }
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
