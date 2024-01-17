# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id         :bigint           not null, primary key
#  name       :string
#  note       :text
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
class Service < ApplicationRecord
  has_many :room_services, dependent: :destroy
  has_many :rooms, through: :room_services

  belongs_to :user
end
