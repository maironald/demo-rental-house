# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id            :bigint           not null, primary key
#  name          :string
#  note          :text
#  price_service :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Service < ApplicationRecord
  has_many :rooms_services, dependent: :destroy, class_name: 'RoomsService'
  has_many :rooms, through: :rooms_services
end
