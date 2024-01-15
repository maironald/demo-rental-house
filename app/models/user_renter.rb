# frozen_string_literal: true

# == Schema Information
#
# Table name: user_renters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  renter_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_renters_on_renter_id  (renter_id)
#  index_user_renters_on_user_id    (user_id)
#
class UserRenter < ApplicationRecord
  belongs_to :user
  belongs_to :renter
end
