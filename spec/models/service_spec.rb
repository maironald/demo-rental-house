# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  note       :text
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_services_on_deleted_at  (deleted_at)
#
require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
