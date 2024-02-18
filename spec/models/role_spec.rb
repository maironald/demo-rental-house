# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:users).join_table(:users_roles) }
    it { should belong_to(:resource).optional }
  end

  describe 'validations' do
    it { should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types).allow_nil }
  end

  describe 'scopes' do
    it '.scopify' do
      expect(Role).to respond_to(:scopify)
    end
  end

  describe 'constants' do
    it 'NAMES' do
      expect(Role::NAMES).to eq(%w[admin user])
    end
  end
end
