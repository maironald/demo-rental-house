# frozen_string_literal: true

# == Schema Information
#
# Table name: renters
#
#  id           :bigint           not null, primary key
#  address      :string
#  deposit      :bigint
#  gender       :string           default("f"), not null
#  identity     :string
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Renter < ApplicationRecord
  has_many :rooms, dependent: nil

  has_many :user_renters, dependent: :destroy
  has_many :users, through: :user_renters

  GENDERS = %w[male female].freeze
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 20 }
  validates :identity, presence: true, length: { maximum: 20 }
  validates :address, :gender, :deposit, presence: true
  validates :gender, inclusion: { in: GENDERS }
end
