# frozen_string_literal: true

module CollectionsHelper
  def renter_name_collections
    Renter::GENDERS
  end

  def renter_type_collections
    Renter::TYPES
  end
end
