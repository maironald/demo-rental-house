# frozen_string_literal: true

# == Schema Information
#
# Table name: timesheets
#
#  id         :bigint           not null, primary key
#  day        :date
#  end_time   :datetime
#  start_time :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Timesheet < ApplicationRecord
  validates :start_time, :end_time, presence: true
  validates :end_time, comparison: { greater_than: :end_time }
end
