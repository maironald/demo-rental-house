# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseController, type: :controller do
  controller do
    def index
      render plain: 'Hello, World!'
    end
  end

  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
