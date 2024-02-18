# frozen_string_literal: true

# == Schema Information
#
# Table name: renters
#
#  id           :bigint           not null, primary key
#  address      :string
#  deposit      :decimal(, )
#  gender       :string           default("f"), not null
#  identity     :string
#  name         :string
#  phone_number :string
#  renter_type  :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  room_id      :bigint
#
FactoryBot.define do
  factory :renter do
    address { Faker::Address.street_name }
    deposit { 0 }
    gender { %w[male female].sample }
    identity { Faker::IDNumber.valid }
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    renter_type { %w[main member].sample }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    association :room
  end
end
