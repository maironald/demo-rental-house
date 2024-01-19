# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string           default(""), not null
#  avatar_url             :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
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
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  after_create :assign_default_role

  has_many :rooms, dependent: :destroy

  has_many :user_renters, dependent: :destroy
  has_many :renters, through: :user_renters

  has_many :services, dependent: :destroy

  has_one :setting, dependent: :destroy

  def self.from_omniauth(auth)
    # create a new user with provider and uid followed by google to add to the database.
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.fullname = auth.info.name # assuming the user model has a name.
      user.avatar_url = auth.info.image # assuming the user model has a image.
      # If you are using the confirmable and the provider(s) you use validate emails, uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  private

  # Add default role to user when you register an account
  def assign_default_role
    add_role(:user)
  end
end
