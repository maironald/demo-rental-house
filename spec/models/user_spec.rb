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
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'scopes' do
    it '.search_by_email' do
      expect(User).to respond_to(:search_by_email)
    end
  end

  describe 'associations' do
    it { should have_many(:rooms).dependent(:destroy) }
    it { should have_many(:services).dependent(:destroy) }
    it { should have_one(:setting).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
    it { should have_many(:notification_mentions).dependent(:destroy) }
  end

  describe '#admin_condition_met?' do
    it 'returns true when the email starts with "admin"' do
      user = User.new(email: 'admin@example.com')
      expect(user.send(:admin_condition_met?)).to be_truthy
    end

    it 'returns false when the email does not start with "admin"' do
      user = User.new(email: 'user@example.com')
      expect(user.send(:admin_condition_met?)).to be_falsey
    end
  end

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'provider_name',
        uid: '123456',
        info: {
          email: 'example@example.com',
          name: 'John Doe'
        }
      )
    end

    it 'creates a new user if user does not exist' do
      expect do
        User.from_omniauth(auth)
      end.to change(User, :count).by(1)
    end

    it 'finds existing user if user already exists' do
      user = User.from_omniauth(auth)
      expect do
        User.from_omniauth(auth)
      end.not_to change(User, :count)

      expect(User.from_omniauth(auth)).to eq(user)
    end

    it 'assigns the correct attributes to the user' do
      user = User.from_omniauth(auth)
      expect(user.email).to eq('example@example.com')
      expect(user.fullname).to eq('John Doe')
    end
  end

  describe 'avatar uploader' do
    it 'correctly mounts the AvatarUploader' do
      expect(User.new).to respond_to(:avatar)
    end

    it 'returns the correct uploader class' do
      expect(User.new.avatar.class).to eq(AvatarUploader)
    end

    it 'uploads an avatar image' do
      user = User.new
      user.avatar = File.open(Rails.root.join('spec/fixtures/avatar_test.png').to_s)
      user.save

      expect(user.avatar.url).not_to be_nil
    end

    it 'deletes an avatar image' do
      user = User.new
      user.avatar = File.open(Rails.root.join('spec/fixtures/avatar_test.png').to_s)
      user.save

      user.avatar.url
      user.remove_avatar!
      user.save

      expect(user.avatar.url).to be_nil
    end
  end

  describe 'soft delete' do
    it 'soft deletes a user' do
      user = User.create(name: 'John Doe', email: 'HjB7H@example.com', password: 'password')
      user.destroy

      expect(User.find_by(name: 'John Doe')).to be_nil
    end

    it 'recovers a soft-deleted user' do
      user = User.create(name: 'Jane Doe', email: 'HjB7H@example.com', password: 'password')
      user.destroy

      expect(User.find_by(name: 'Jane Doe')).to be_nil

      user.save!
      user.restore

      expect(User.find_by(name: 'Jane Doe')).not_to be_nil
    end

    it 'excludes soft-deleted users from default scope' do
      user = User.create(name: 'Jessica Doe', email: 'HjB7H@example.com', password: 'password')
      user.destroy

      expect(User.all).not_to include(user)
    end
  end
end
