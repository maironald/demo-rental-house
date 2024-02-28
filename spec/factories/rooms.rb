# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id                  :bigint           not null, primary key
#  deleted_at          :datetime
#  description         :text
#  electric_amount_new :integer
#  electric_amount_old :integer
#  length              :integer
#  limit_residents     :integer
#  name                :string
#  price_room          :bigint
#  rental_speriod      :datetime
#  water_amout_new     :integer
#  water_amout_old     :integer
#  width               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_rooms_on_deleted_at        (deleted_at)
#  index_rooms_on_name_and_user_id  (name,user_id) UNIQUE
#  index_rooms_on_user_id           (user_id)
#
FactoryBot.define do
  factory :room do
    description { Faker::Lorem.paragraph }
    electric_amount_new { Faker::Number.between(from: 100, to: 200) }
    electric_amount_old { Faker::Number.between(from: 50, to: 99) }
    length { Faker::Number.digit }
    limit_residents { Faker::Number.digit }
    name { Faker::Lorem.word }
    price_room { Faker::Number.decimal }
    water_amout_new { Faker::Number.between(from: 100, to: 200) }
    water_amout_old { Faker::Number.between(from: 50, to: 99) }
    width { Faker::Number.digit }
    association :user, factory: :user
  end
end
