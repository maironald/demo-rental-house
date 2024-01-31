# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = Noticed::Event.where(type: 'NotificationsNotifier')
    @pagy, @notifications = pagy(@notifications, items: 9)
  end

  def show
    @notification_event = Noticed::Event.find(params[:id])
    @notification = current_user.notifications.find_by(event_id: @notification_event.id)
    @notification.mark_as_read!
    # debugger
  end

  def new; end

  def edit; end

  def create
    NotificationsNotifier.with(message: { title: params[:title], body: params[:body] }).deliver(User.where.not(id: current_user.id))
    # debugger
    redirect_to admins_notifications_path
  end

  def update; end

  def destroy; end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end
