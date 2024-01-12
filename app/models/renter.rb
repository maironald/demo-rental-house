# frozen_string_literal: true

# == Schema Information
#
# Table name: renters
#
#  id           :bigint           not null, primary key
#  address      :string
#  deposit      :bigint
#  gender       :boolean
#  identity     :string
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Renter < ApplicationRecord
  has_many :rooms, dependent: nil
  accepts_nested_attributes_for :rooms

  validates :name, presence: true
end
