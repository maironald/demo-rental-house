# frozen_string_literal: true

# To deliver this notification:
#
# Notifications.with(record: @post, message: "New post").deliver(User.all)

class NotificationsNotifier < ApplicationNotifier
  # deliver_by :email do |config|
  #   config.mailer = 'UserMailer'
  #   config.method = 'new_comment'
  #   # define the user who will receive the notification
  #   config.params = ->(recipient) { { user: recipient } }
  #   # config.args = :email_args
  #   # config.wait = 5.minutes # it will wait 5 minutes and after that, it will run the job for this recipient to send them an email.
  # end
  deliver_by :action_cable do |config|
    config.channel = 'Noticed::NotificationsChannel'
    config.stream = -> { recipient }
    config.message = -> { params.merge(user_id: recipient.id) }
  end
  # notification_methods do
  #   def title
  #     (params['message']['title']).to_s
  #   end

  #   def body
  #     (params['message']['body']).to_s
  #   end

  #   def created_at
  #     created_at.strftime('%d-%m-%Y %H:%M')
  #   end
  # end

  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end
