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
    it { should validate_length_of(:name).is_at_most(50) }

    it { should validate_presence_of(:length) }
    it { should validate_numericality_of(:length).is_less_than_or_equal_to(20_000) }

    it { should validate_presence_of(:width) }
    it { should validate_numericality_of(:width).is_less_than_or_equal_to(20_000) }

    it { should validate_presence_of(:electric_amount_new) }

    it { should validate_presence_of(:electric_amount_old) }

    it { should validate_presence_of(:price_room) }

    it { should validate_presence_of(:limit_residents) }
    it { should validate_numericality_of(:limit_residents).only_integer }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:water_amout_new) }

    it { should validate_presence_of(:water_amout_old) }

    it 'validates electric amount' do
      subject.electric_amount_new = 10
      subject.electric_amount_old = 5
      subject.validate
      expect(subject.errors[:base]).to_not include('Electric amount new must be greater than electric amount old')
    end

    it 'validates water amount' do
      subject.water_amout_new = 100
      subject.water_amout_old = 50
      subject.validate
      expect(subject.errors[:base]).to_not include('Water amount new must be greater than water amount old')
    end
  end

  describe 'associations' do
    it { should have_many(:renters) }
    it { should belong_to(:user) }
    it { should have_many(:invoices) }
  end

  describe 'scopes' do
    it '.search_by_name' do
      expect(Room).to respond_to(:search_by_name)
    end

    it '.filter_room_rented' do
      expect(Room).to respond_to(:rooms_rented)
    end

    it 'filter_room_empty' do
      expect(Room).to respond_to(:rooms_empty)
    end
  end

  describe '#check_electric_amount' do
    context 'when electric_amount_new is not greater than electric_amount_old' do
      it 'adds an error to base_electric' do
        subject.electric_amount_new = 10
        subject.electric_amount_old = 15
        subject.check_electric_amount
        expect(subject.errors[:base_electric]).to include('The amount of new electricity needs to be greater than the old one!')
      end
    end

    context 'when electric_amount_new is greater than electric_amount_old' do
      it 'does not add an error' do
        subject.electric_amount_new = 20
        subject.electric_amount_old = 15
        subject.check_electric_amount
        expect(subject.errors[:base_electric]).to be_empty
      end
    end
  end
end
