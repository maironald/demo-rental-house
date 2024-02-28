# frozen_string_literal: true

#
# == Schema Information
#
# Table name: settings
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  price_electric :decimal(, )      default(0.0)
#  price_internet :decimal(, )      default(0.0)
#  price_security :decimal(, )      default(0.0)
#  price_trash    :decimal(, )      default(0.0)
#  price_water    :decimal(, )      default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_settings_on_deleted_at  (deleted_at)
#  index_settings_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :setting do
    price_electric { Faker::Number.between(from: 10_000.0, to: 15_000.0) }
    price_internet { Faker::Number.between(from: 10_000.0, to: 15_000.0) }
    price_security { Faker::Number.between(from: 10_000.0, to: 15_000.0) }
    price_trash { Faker::Number.between(from: 10_000.0, to: 15_000.0) }
    price_water { Faker::Number.between(from: 10_000.0, to: 15_000.0) }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    association :user, factory: :user
  end
end
