# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id         :bigint           not null, primary key
#  name       :string
#  note       :text
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
FactoryBot.define do
  factory :service do
    name { Faker::Lorem.sentence }
    note { Faker::Lorem.paragraph }
    price { 0 }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    association :user, factory: :user
  end
end
