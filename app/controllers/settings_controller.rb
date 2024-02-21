# frozen_string_literal: true

class SettingsController < BaseController
  before_action :set_setting, only: %i[edit update]
  def edit; end

  def update
    if current_user.setting.update(setting_params)
      respond_to do |format|
        format.html { redirect_to rooms_path, notice: 'You change the value price of all services room successfully.' }
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('room-list', partial: 'rooms/table', locals: { rooms: @rooms }), turbo_stream.remove('remote_modal')]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def setting_params
    params.require(:setting).permit(:price_electric, :price_water, :price_security, :price_internet, :price_trash)
  end

  def set_setting
    @setting = current_user.setting
  end
end
