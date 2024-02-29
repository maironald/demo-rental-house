# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include TurboRenderable

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  helper_method :user_notifications, :user_content_notification, :check_unread_noti

  protected

  def user_notifications
    @user_notifications = current_user.notifications
  end

  def user_content_notification(event_id)
    @user_content_notification = Noticed::Event.find_by(id: event_id)
  end

  def check_unread_noti
    current_user.notifications.unread.exists?
  end

  def check_authorize(record, query = nil)
    authorize(record, query, policy_class: "#{controller_path.classify}Policy".constantize)
  end
end
