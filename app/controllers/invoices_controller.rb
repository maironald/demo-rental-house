# frozen_string_literal: true

class InvoicesController < BaseController
  before_action :prepare_index, only: %i[index show_all_invoices]
  before_action :calculate_total_price, only: %i[new edit create update]
  before_action :set_total_price_param, only: %i[create update]
  before_action :set_room, only: %i[new update create edit]
  before_action :set_invoice, only: %i[destroy update edit]
  before_action :set_renter, only: %i[new create edit update]
  before_action :set_setting, only: %i[new create edit update]

  def index; end

  def show; end

  def new
    @invoice = Invoice.new
    @invoice.name = generate_random_code
  end

  def show_all_invoices; end

  def edit
    @invoice.paid_money = format_to_vnd_not_unit(@invoice.paid_money)
  end

  def create
    remove_decimal_separator(params[:invoice], %i[paid_money])
    @invoice = @room.invoices.new(invoice_params)
    render_result_action(@invoice.save, :new)
  end

  def update
    remove_decimal_separator(params[:invoice], %i[paid_money])
    render_result_action(@invoice.update(invoice_params), :edit)
  end

  def destroy
    @invoice.really_destroy!
    redirect_to show_all_invoices_invoices_path, notice: 'Invoices was successfully deleted.'
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

  def set_setting
    @settings = current_user.setting
  end

  def set_total_price_param
    params[:invoice][:total_price] = @result[:total_invoice_price]
  end

  def set_renter
    @renter = Renter.find_by(room_id: params[:room_id], renter_type: 'main') || nil
  end

  def remove_decimal_separator(params_hash, keys)
    keys.each do |key|
      next if params_hash[key].blank? # Skip if the key is blank or nil

      params_hash[key] = params_hash[key].delete('.') if params_hash[key].respond_to?(:delete)
    end
  end

  def calculate_total_price
    room = Room.find(params[:room_id])
    @result = Invoices::GetTotalPriceService.call(room, current_user)
  end

  def render_result_action(result, action, path = show_all_invoices_invoices_path, model = "Invoice: #{@invoice.name}")
    name = 'invoice_list'
    frame_back_name = 'new_invoice'
    render_result(result:, path:, model:, action:, name:, frame_back_name:)
  end

  def prepare_index
    @invoices = Invoice.joins(:room).where(rooms: { user_id: current_user.id })
    @invoices = @invoices.search_by_name(params[:search]) if params[:search]
    @invoices = @invoices.total_price_greater_than_paid_money if params[:selected_value] == 'unpaid'
    @invoices = @invoices.total_price_equal_with_paid_money if params[:selected_value] == 'paid'

    @pagy, @invoices = pagy(@invoices, items: 9)
  end

  def generate_random_code
    # Generate a random code here. This is just a simple example.
    # You might want to use a more sophisticated method to generate a unique code.
    SecureRandom.hex(3).upcase
  end
end
