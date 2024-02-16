# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'after_sign_out_path_for' do
    it 'returns new_user_session_path' do
      path = controller.send(:after_sign_out_path_for, nil)

      expect(path).to eq(new_user_session_path)
    end
  end
end
