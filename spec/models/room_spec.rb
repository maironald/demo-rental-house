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
#  index_rooms_on_deleted_at  (deleted_at)
#  index_rooms_on_user_id     (user_id)
#
require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:length) }
    it { should validate_presence_of(:width) }
    it { should validate_presence_of(:price_room) }
    it { should validate_presence_of(:limit_residents) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:renters) }
    it { should belong_to(:user) }
    it { should have_many(:invoices) }
  end

  describe 'scopes' do
    it '.search_by_name' do
      expect(described_class).to respond_to(:search_by_name)
    end

    it '.rooms_rented' do
      expect(described_class).to respond_to(:rooms_rented)
    end

    it 'rooms_empty' do
      expect(described_class).to respond_to(:rooms_empty)
    end
  end

  user = FactoryBot.create(:room, water_amout_new: 10, water_amout_old: 5)

  describe 'method' do
    it 'return the amount of water' do
      expect(user.calculate_water_amount).to eq(5)
    end

    it 'return the amount of electric' do
      user = FactoryBot.create(:room, electric_amount_new: 10, electric_amount_old: 5)
      expect(user.calculate_electric_amount).to eq(5)
    end

    it 'return true if calculate_water_amount < 0' do
      user = FactoryBot.create(:room, water_amout_new: 10, water_amout_old: 15)
      expect(user.check_electric_water_amount).to eq(true)
    end

    it 'return true if calculate_electric_amount < 0' do
      user = FactoryBot.create(:room, electric_amount_new: 10, electric_amount_old: 15)
      expect(user.check_electric_water_amount).to eq(true)
    end
  end
end
