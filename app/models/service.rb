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
#  user_id    :bigint
#
class Service < ApplicationRecord
  belongs_to :user

  # validations
  validates :name, presence: true
  validates :price, presence: true
end
