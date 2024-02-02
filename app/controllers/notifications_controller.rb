# frozen_string_literal: true

class NotificationsController < BaseController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[show edit update destroy]
  def index
    @notifications = Noticed::Event.where(type: 'NotificationsNotifier')
    @pagy, @notifications = pagy(@notifications, items: 9)
  end

  def show
    @notification_event = Noticed::Event.find(params[:id])
    @notification = current_user.notifications.find_by(event_id: @notification_event.id)
    @notification.mark_as_read!
  end

  def new; end

  def edit; end

  def create
    NotificationsNotifier.with(message: { title: params[:title], body: params[:body] }).deliver(User.where.not(id: current_user.id))
    redirect_to admins_notifications_path
  end

  def update; end

  def destroy
    @notification_sending = Noticed::Notification.find_by(event_id: params[:id])
    @notifications = Noticed::Event.where(type: 'NotificationsNotifier')
    return unless @notification.destroy && @notification_sending.destroy

    respond_to do |format|
      format.html { redirect_to admins_notifications_path, notice: 'Notification was successfully deleted.' }
    end
  end

  private

  def set_notification
    @notification = Noticed::Event.find(params[:id])
  end
end
