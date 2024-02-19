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

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { should belong_to(:room) }
  end

  describe 'scopes' do
    it '.total_price_greater_than_paid_money' do
      expect(Invoice).to respond_to(:total_price_greater_than_paid_money)
    end

    it '.total_price_equal_with_paid_money' do
      expect(Invoice).to respond_to(:total_price_equal_with_paid_money)
    end

    it '.search_by_name' do
      expect(Invoice).to respond_to(:search_by_name)
    end
  end
end
