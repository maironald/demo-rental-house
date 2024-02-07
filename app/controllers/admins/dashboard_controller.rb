# frozen_string_literal: true

module Admins
  class DashboardController < BaseController
    def index
      @users = User.with_role(:user).without_deleted
      @users = @users.search_by_email(params[:search]) if params[:search]
      @count = @users.count

      @pagy, @users = pagy(@users, items: 9)
    end

    def edit_password_user
      @user = User.find(params[:id])
    end

    def update_password_user
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admins_dashboard_index_path, notice: 'Password updated successfully.'
      else
        render :edit_password
      end
    end

    def show_all_users_deleted
      @users = User.only_deleted
      @users = @users.search_by_email(params[:search]) if params[:search]
      @count = @users.count

      @pagy, @users = pagy(@users, items: 9)
    end

    def delete_user_account
      @user = User.find(params[:id])
      @user.destroy!
      respond_to do |format|
        format.html { redirect_to admins_dashboard_index_path, notice: 'User was successfully inactived.' }
      end
    end

    def restore_deleted_user
      @user = User.only_deleted.find(params[:id])
      return unless @user.restore(recursive: true)

      respond_to do |format|
        format.html { redirect_to admins_dashboard_index_path, notice: 'User was successfully actived again.' }
      end
    end

    def destroy_user_account
      @user = User.only_deleted.find(params[:id])
      @user.restore
      @user = User.find(params[:id])
      @user.really_destroy!
      respond_to do |format|
        format.html { redirect_to show_all_users_deleted_admins_dashboard_index_path, notice: 'User was successfully permanently deleted.' }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
