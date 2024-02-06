# frozen_string_literal: true

class AddProviderFullnameUidAvatarurlToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :fullname
      t.string :uid
      t.string :avatar
      t.string :provider
    end
  end
end
