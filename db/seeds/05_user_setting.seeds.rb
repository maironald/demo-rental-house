# frozen_string_literal: true

puts 'Create settings'

10.times.each do |n|
  Setting.create! do |setting|
    setting.price_water = 10_000
    setting.price_electric = 10_000
    setting.price_internet = 10_000
    setting.price_trash = 10_000
    setting.price_security = 10_000
    setting.user_id = n + 2
  end
end
