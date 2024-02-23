# frozen_string_literal: true

class RentersController < BaseController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  before_action :set_renter, only: %i[show edit update destroy]

  def index
    # get all the renters id who have rented a room through current user
    @room_ids = current_user.rooms.pluck(:id)
    @renters = Renter.where(room_id: @room_ids)
    @renters = @renters.search_by_name(params[:search], @room_ids) if params[:search]
    @renters = @renters.filter_renter_type(params[:selected_value]) if params[:selected_value] == 'main' || params[:selected_value] == 'member'

    @pagy, @renters = pagy(@renters, items: 9)
  end

  def show; end

  def new
    @renter = Renter.new
  end

  def edit
    @renter.deposit = format_to_vnd_not_unit(@renter.deposit)
  end

  def create
    remove_decimal_separator(params[:renter], %i[deposit])
    @room = Room.find_by(id: params[:room_id])
    @renter = @room.renters.build(renter_params)
    # @room_info = Room.find_by(id: renter_params[:rooms_attributes]['0'][:id])

    # Find the main renter of the room to replace another new main renter in the same room.
    Renter.find_by(room_id: params[:room_id], renter_type: 'main')&.update(renter_type: 'member') if renter_params[:renter_type] == 'main'
    respond_to do |format|
      if @renter.save
        reload_rooms_with_create(format, type: :success, message: "The renter '#{@renter.name}' was successfully created.")
      else
        render_errors(format, :new)
      end
    end
  end

  def update
    remove_decimal_separator(params[:renter], %i[deposit])
    respond_to do |format|
      if @renter.update(renter_params)
        reload_rooms_with_update_destroy(format, type: :success, message: "The renter '#{@renter.name}' was successfully edited.")
      else
        render_errors(format, :edit)
      end
    end
  end

  def destroy
    @renter.really_destroy!
    respond_to do |format|
      reload_rooms_with_update_destroy(format, type: :success, message: "The renter '#{@renter.name}' was successfully deleted.")
    end
  end

  def destroy_all
    Renter.destroy_all
    respond_to do |format|
      reload_rooms_with_update_destroy(format, type: :success, message: 'Renter was successfully deleted all.')
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

  def count_people_in_room
    @room_total = current_user.rooms.count
    @room_used = Renter.where(room_id: current_user.rooms.pluck(:id), renter_type: 'main').count
    @room_left = @room_total - @room_used
  end

  def reload_rooms_with_create(format, options = {})
    @rooms = current_user.rooms.all
    @total_rooms = @rooms.count
    count_people_in_room
    @pagy, @rooms = pagy(@rooms, items: 9)
    format.html { redirect_to rooms_path, notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('room_list', partial: 'rooms/table', locals: { rooms: @rooms, pagy: @pagy, total_rooms: @total_rooms, room_used: @room_used, room_left: @room_left }),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def reload_rooms_with_update_destroy(format, options = {})
    @room_ids = current_user.rooms.pluck(:id)
    @renters = Renter.where(room_id: @room_ids)
    @pagy, @renters = pagy(@renters, items: 9)
    format.html { redirect_to renters_path, notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('renter_list', partial: 'renters/table', locals: { renters: @renters }),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_renter', partial: 'renters/form')] }
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      params_hash[key] = params_hash[key].delete('.')
    end
  end
end
