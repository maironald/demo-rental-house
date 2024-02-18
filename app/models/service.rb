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
class Service < ApplicationRecord
  acts_as_paranoid
  belongs_to :user

  # validations
  validates :name, presence: true
  validates :price, presence: true
end
