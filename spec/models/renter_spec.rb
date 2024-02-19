# frozen_string_literal: true

# == Schema Information
#
# Table name: renters
#
#  id           :bigint           not null, primary key
#  address      :string
#  deleted_at   :datetime
#  deposit      :decimal(, )
#  gender       :string           default("f"), not null
#  identity     :string
#  name         :string
#  phone_number :string
#  renter_type  :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  room_id      :bigint
#
# Indexes
#
#  index_renters_on_deleted_at  (deleted_at)
#  index_renters_on_room_id     (room_id)
#
require 'rails_helper'
RSpec.describe Renter, type: :model do
  describe 'constants' do
    it 'NAMES' do
      expect(Renter::GENDERS).to eq(%w[male female])
    end

    it 'TYPES' do
      expect(Renter::TYPES).to eq(%w[main member])
    end
  end

  describe 'associations' do
    it { should belong_to(:room).dependent(nil) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:identity) }
    it { should validate_presence_of(:address) }
    it { should validate_inclusion_of(:gender).in_array(Renter::GENDERS) }
    it { should validate_inclusion_of(:renter_type).in_array(Renter::TYPES) }
  end

  describe 'scopes' do
    it '.search_by_name' do
      expect(Renter).to respond_to(:search_by_name)
    end

    it '.filter_renter_type' do
      expect(Renter).to respond_to(:filter_renter_type)
    end
  end
end
