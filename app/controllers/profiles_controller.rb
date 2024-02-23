# frozen_string_literal: true

class ProfilesController < BaseController
  include ApplicationHelper
  def edit_information
    @user = current_user
  end

  def update_information
    @user = current_user
    respond_to do |format|
      if @user&.update(user_params) && @user&.has_role?(:user)
        reload_page(format, path: users_dashboard_index_path, type: :success, message: 'Your information was successfully updated.')
      elsif @user&.update(user_params) && @user&.has_role?(:admin)
        reload_page(format, path: admins_dashboard_index_path, type: :success, message: 'Your information was successfully updated.')
      else
        render_errors(format, :edit_information)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :address, :phone_number, :email, :avatar)
  end

  def reload_page(format, options = {})
    format.html { redirect_to options[:path], notice: options[:message] }
    format.turbo_stream do
      flash.now[options[:type]] = options[:message]
      render turbo_stream: [
        turbo_stream.remove('my_modal_4'),
        turbo_stream.replace('avatar_info', partial: 'users/topnav'),
        render_turbo_stream_flash_messages
      ]
    end
  end

  def render_errors(format, action)
    format.html { render action, status: :unprocessable_entity }
    format.turbo_stream { render turbo_stream: [turbo_stream.replace('new_user', partial: 'profiles/form_information')] }
  end
end
