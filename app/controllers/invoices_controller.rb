# frozen_string_literal: true

class InvoicesController < BaseController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  before_action :calculate_total_price, only: %i[new create edit update]
  before_action :set_total_price_param, only: %i[create update]
  before_action :set_room, only: %i[create]
  before_action :set_invoice, only: %i[destroy update]

  def index; end

  def show; end

  def new
    @settings = current_user.setting
  end

  def edit
    @room = Room.find(params[:room_id])
    @invoice = Invoice.find(params[:id])
    @invoice.paid_money = format_to_vnd_not_unit(@invoice.paid_money)
  end

  def create
    remove_decimal_separator(params[:invoice], %i[paid_money])
    respond_to do |format|
      @invoice = @room.invoices.build(invoice_params)
      if @invoice.save
        reload_invoices_with_create(format, type: :success, message: "The invoice '#{@invoice.name}' was successfully created.")
      else
        render_errors(format, :new)
      end
    end
  end

  def show_all_invoices
    @room_ids = current_user.rooms.pluck(:id)
    @invoices = Invoice.where(room_id: @room_ids)
    @invoices = @invoices.search_by_name(params[:search], @room_ids) if params[:search]
    @invoices = @invoices.total_price_greater_than_paid_money if params[:selected_value] == 'unpaid'
    @invoices = @invoices.total_price_equal_with_paid_money if params[:selected_value] == 'paid'

    @pagy, @invoices = pagy(@invoices, items: 9)
  end

  def update
    remove_decimal_separator(params[:invoice], %i[paid_money])
    respond_to do |format|
      if @invoice.update(invoice_params)
        reload_invoices_with_update_destroy(format, type: :success, message: "The invoice '#{@invoice.name}' was successfully edited.")
      else
        render_errors(format, :edit)
      end
    end
  end

  def destroy
    @invoice.really_destroy!
    respond_to do |format|
      reload_invoices_with_update_destroy(format, type: :success, message: "The invoice '#{@invoice.name}' was successfully deleted.")
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :total_price, :paid_money)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_total_price_param
    params[:invoice][:total_price] = @total_price
  end

  def calculate_total_price
    @invoice = Invoice.new
    @room = Room.find(params[:room_id])
    @renter = Renter.find_by(room_id: params[:room_id], renter_type: 'main') || nil
    @total_electric_price = (@room.electric_amount_new - @room.electric_amount_old).to_d * current_user.setting.price_electric
    @total_water_price = (@room.water_amout_new - @room.water_amout_old).to_d * current_user.setting.price_water
    @total_price = @total_electric_price + @total_water_price + @room.price_room + current_user.setting.price_internet + current_user.setting.price_security + current_user.setting.price_trash
  end

  def count_people_in_room
    @room_total = current_user.rooms.count
    @room_used = Renter.where(room_id: current_user.rooms.pluck(:id), renter_type: 'main').count
    @room_left = @room_total - @room_used
  end

  def reload_invoices_with_create(format, options = {})
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

  def reload_invoices_with_update_destroy(format, options = {})
    @room_ids = current_user.rooms.pluck(:id)
    @invoices = Invoice.where(room_id: @room_ids)
    @pagy, @invoices = pagy(@invoices, items: 9)
    format.html { redirect_to show_all_invoices_invoices_path, notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('invoice_list', partial: 'invoices/table', locals: { invoices: @invoices }),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_invoice', partial: 'invoices/invoice_room')] }
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      params_hash[key] = params_hash[key].delete('.')
    end
  end
end
