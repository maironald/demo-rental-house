# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :authenticate_user!

  helper_method :user_notifications, :user_content_notification, :check_unread_noti
  def user_notifications
    @user_notifications = current_user.notifications
    # debugger
  end

  def user_content_notification(event_id)
    @user_content_notification = Noticed::Event.find_by(id: event_id)
  end

  def check_unread_noti
    current_user.notifications.unread.exists?
  end
end
