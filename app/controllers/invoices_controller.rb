class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :calculate_total_price, only: %i[new create edit]
  def index
    @invoices = Invoice.all
  end

  def show; end
  def new
    @room_services = RoomService.where(room_id: @room.id) || nil
    if !@room_services.nil?
      @services = @room_services.map { |service| Service.find_by(id: service.service_id)}
    end
  end

  def create
    # debugger
    @room = Room.find(params[:id])
    @invoice = @room.invoices.build(invoice_params)
    if @invoice.save
      respond_to do |format|
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show_all_invoices
    @invoices = Invoice.all
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_path, notice: 'Invoicewas successfully deleted.' }
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :total_price, :paid_money)
  end

  def calculate_total_price
    @invoice = Invoice.new
    @room = Room.find(params[:id])
    @renter = Renter.find_by(id: @room.renter_id) || nil
    @total_electric_price = (@room.electric_amount_new - @room.electric_amount_old).to_d * current_user.electric_price
    @total_water_price = (@room.water_amout_new - @room.water_amout_old).to_d * current_user.water_price
    @total_price = @total_electric_price + @total_water_price + @room.price_room
  end
end
