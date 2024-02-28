# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  name        :string
#  paid_money  :decimal(, )      default(0.0)
#  total_price :decimal(, )      default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  room_id     :bigint
#
# Indexes
#
#  index_invoices_on_deleted_at  (deleted_at)
#  index_invoices_on_room_id     (room_id)
#
FactoryBot.define do
  factory :invoice do
    name { Faker::Lorem.sentence }
    paid_money { Faker::Number.decimal }
    total_price { Faker::Number.decimal }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    association :room
  end
end
