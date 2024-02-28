# frozen_string_literal: true

class ProfilesController < BaseController
  before_action :set_user, only: %i[edit_information update_information]
  before_action :prepare_show, only: %i[edit_information]
  def edit_information; end

  def update_information
    respond_to do |format|
      if @user&.update(user_params) && @user&.has_role?(:user)
        reload_page(format, path: users_dashboard_index_path, type: :success, message: 'Your information was successfully updated.')
      elsif @user&.update(user_params) && @user&.has_role?(:admin)
        reload_page(format, path: admin_dashboard_index_path, type: :success, message: 'Your information was successfully updated.')
      else
        render_errors(format, :edit_information)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :address, :phone_number, :email, :avatar)
  end

  def set_user
    @user = current_user
  end

  def reload_page(format, options = {})
    prepare_show
    format.html { redirect_to options[:path], notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('avatar_info', partial: 'users/avatar', locals: { user: current_user, room_tota: @room_total, room_used: @room_used, room_left: @room_left, renters: @renters, renter_main: @renter_main, renter_member: @renter_member }),
        turbo_stream.replace('profile_info', partial: 'profiles/form_information'),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_user', partial: 'profiles/form_information')] }
  end

  def prepare_show
    @rooms = current_user.rooms
    @room_total = @rooms.size
    @room_used = @rooms.rooms_rented.size
    @room_left = @room_total - @room_used
    current_user_renters = Renter.joins(room: :user).where(users: { id: current_user.id })
    @renters = current_user_renters.size
    @renter_main = current_user_renters.renters_main.size
    @renter_member = current_user_renters.renters_member.size
  end
end
