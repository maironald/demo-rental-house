# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :authenticate_user!
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
  end

  def create
    @invoice = @room.invoices.build(invoice_params)
    if @invoice.save
      respond_to do |format|
        format.html { redirect_to show_all_invoices_invoices_path, notice: 'Invoice was successfully created.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('invoice-list', partial: 'invoices/table', locals: { invoice: @invoice }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show_all_invoices
    @room_ids = current_user.rooms.pluck(:id)
    @invoices =  if params[:search].present?
                  @invoices = Invoice.where('invoices.name LIKE ? AND room_id IN (?)', "%#{params[:search]}%", @room_ids)
                else
                  @invoices = Invoice.where(room_id: @room_ids)
                end

    selected_value = params[:selected_value]
    if selected_value == 'unpaid'
      @invoices = @invoices.total_price_greater_than_paid_money
    elsif selected_value == 'paid'
      @invoices = @invoices.total_price_equal_with_paid_money
    else
      @invoices
    end

    @pagy, @invoices = pagy(@invoices, items: 9)
  end

  def update
    if @invoice.update(invoice_params)
      respond_to do |format|
        format.html { redirect_to show_all_invoices_invoices_path, notice: 'Invoice was successfully edited.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('invoice-list', partial: 'invoices/table', locals: { invoice: @invoice }), turbo_stream.remove('my_modal_4')]
        end
      end
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to show_all_invoices_invoices_path, notice: 'Invoice was successfully deleted.' }
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
end
