# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  it 'broadcasts a message to the channel' do
    message = { body: 'New notification' }
    expect do
      ActionCable.server.broadcast('notifications', message)
    end.to have_broadcasted_to('notifications').with(message)
  end
end
