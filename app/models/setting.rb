# frozen_string_literal: true

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
class Setting < ApplicationRecord
  acts_as_paranoid
  belongs_to :user

  validates :price_electric, presence: true
  validates :price_internet, presence: true
  validates :price_security, presence: true
  validates :price_trash, presence: true
  validates :price_water, presence: true
end
