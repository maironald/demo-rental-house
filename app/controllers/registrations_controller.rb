# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def new
    super do |resource|
      flash[:notice] = t('devise.registrations.signed_up_but_unconfirmed') if resource.persisted?
    end
  end
end
