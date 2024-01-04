# frozen_string_literal: true

class RolifyCreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table(:roles) do |t| # create_table(roles) is the same with create_table :roles
      t.string :name
      t.references :resource, polymorphic: true

      t.timestamps
    end

    #The id: false option indicates that this table won't have a primary key column. Instead, it relies on the combination of user_id and role_id as a composite primary key.
    create_table(:users_roles, id: false) do |t|
      t.references :user
      t.references :role
    end


    add_index(:roles, %i[name resource_type resource_id]) # This line adds an index to the name, resource_type, and resource_id columns in the roles table.
    add_index(:users_roles, %i[user_id role_id])
  end
end
