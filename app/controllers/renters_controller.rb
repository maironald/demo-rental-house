# frozen_string_literal: true

class RentersController < ApplicationController
  before_action :set_renter, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    # get all the renters id who have rented a room by current user
    @renter_id = UserRenter.where(user_id: current_user.id).pluck(:renter_id)
    @renters = Renter.where(id: @renter_id)
  end

  def show; end

  def new
    @renter = Renter.new
  end

  def edit
    # @default_rooms = current_user.rooms.select { |room| room.renter_id.nil? }
  end

  def create
    @renter = Renter.new(renter_params)
    # @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])
    if @renter.save
      @user_renter = UserRenter.new(user_id: current_user.id, renter_id: @renter.id)
      @user_renter.save
      # Room.where(id: @room_info.id).update(renter_id: @renter.id)
      respond_to do |format|
        format.html { redirect_to users_renters_path, notice: 'Renter was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])
    if @renter.update(renter_params)
      respond_to do |format|
        format.html { redirect_to users_renters_path, notice: "Renter was successfully edited but You didn't change the room." }
      end
    else
      render :edit
    end
  end

  def destroy
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
    params.require(:renter).permit(:name, :phone_number, :identity, :address, :gender, :deposit)
  end
end
