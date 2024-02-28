# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string           default(""), not null
#  avatar                 :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  fullname               :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string           default(""), not null
#  phone_number           :string           default(""), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(Devise.password_length.first).is_at_most(Devise.password_length.last) }
  end

  describe 'associations' do
    it { should have_many(:rooms).dependent(:destroy) }
    it { should have_many(:services).dependent(:destroy) }
    it { should have_one(:setting).dependent(:destroy) }
    it { should have_many(:invoices).dependent(:destroy).through(:rooms) }
  end

  describe 'methods' do
    describe '.from_omniauth' do
      let(:auth) do
        OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '123456',
                               info: { email: 'test@example.com', name: 'Test User', image: 'https://example.com/avatar.jpg' })
      end

      context 'when user exists with the given provider and uid' do
        it 'returns the existing user' do
          existing_user = create(:user, provider: 'google_oauth2', uid: '123456')
          expect(described_class.from_omniauth(auth)).to eq(existing_user)
        end
      end

      context 'when user does not exist with the given provider and uid' do
        it 'creates a new user with the provided information' do
          expect do
            described_class.from_omniauth(auth)
          end.to change(described_class, :count).by(1)
        end
      end
    end
  end
end
