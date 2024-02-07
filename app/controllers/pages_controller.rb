# frozen_string_literal: true

class PagesController < BaseController
  def edit_information
    @user = current_user
  end

  def update_information
    @user = current_user
    if @user&.update(user_params) && @user&.has_role?(:user)
      respond_to do |format|
        format.html { redirect_to users_dashboard_index_path, notice: 'User information was successfully edited.' }
        # format.turbo_stream
        format.turbo_stream do
          render turbo_stream: [turbo_stream.prepend('renter-list', partial: 'renters/table', locals: { renter: @renter }), turbo_stream.remove('my_modal_4')]
        end
      end
    elsif @user&.update(user_params) && @user&.has_role?(:admin)
      redirect_to admins_dashboard_index_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :address, :phone_number, :email, :avatar)
  end
end
