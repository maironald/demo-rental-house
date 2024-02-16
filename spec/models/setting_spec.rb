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
require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end
end
