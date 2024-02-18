# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#after_sign_in_path_for' do
    context 'when the user is an admin' do
      it 'redirects to the admin root path after sign-in' do
        admin_user = FactoryBot.create(:user, :admin)
        path = controller.send(:after_sign_in_path_for, admin_user)
        expect(path).to eq(admins_root_path)
      end
    end

    context 'when the user is a regular user' do
      it 'redirects to the users root path after sign-in' do
        regular_user = FactoryBot.create(:user)
        path = controller.send(:after_sign_in_path_for, regular_user)
        expect(path).to eq(users_root_path)
      end
    end
  end
end
