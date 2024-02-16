# frozen_string_literal: true

#
# == Schema Information
#
# Table name: settings
#
#  id             :bigint           not null, primary key
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
#  index_settings_on_user_id  (user_id)
#
# Foreign Keys
#
FactoryBot.define do
  factory :setting do
    price_electric { 0 }
    price_internet { 0 }
    price_security { 0 }
    price_trash { 0 }
    price_water { 0 }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    association :user, factory: :user
  end
end
