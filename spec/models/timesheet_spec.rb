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
require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
