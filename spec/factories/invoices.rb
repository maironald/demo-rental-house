# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  name        :string
#  paid_money  :decimal(10, 2)   default(0.0)
#  total_price :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  room_id     :bigint
#
FactoryBot.define do
  factory :invoice do
    name { Faker::Lorem.sentence }
    paid_money { 0 }
    total_price { Faker::Number.decimal }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    association :room
  end
end
