# frozen_string_literal: true

# Usage:
#
# class ActivateUserService < ApplicationService
#   attr_reader :user
#
#   def initialize(user)
#     @user = user
#   end
#
#   def call
#     user.activate!
#     NotificationsMailer.user_activation_notification(user).deliver_later
#     user
#   end
# end
#
# user = User.find(1)
# ActivateUserService.call(user)

class ApplicationService
  def self.call(*)
    new(*).call
  end

  def call
    raise NotImplementedError, "You must define `call` as instance method in #{self.class.name} class"
  end
end
