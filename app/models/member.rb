# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id           :bigint           not null, primary key
#  gender       :string           default("f"), not null
#  identity     :string
#  name         :string
#  phone_number :string
#  relation     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  renter_id    :bigint           not null
#
# Indexes
#
#  index_members_on_renter_id  (renter_id)
#
# Foreign Keys
#
#  fk_rails_...  (renter_id => renters.id)
#
class Member < ApplicationRecord
  belongs_to :renter
end
