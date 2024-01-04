# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''  # The user's email, which must be unique and not null.
      t.string :encrypted_password, null: false, default: ''  # The encrypted password, which must be present and not null.

      ## Recoverable
      t.string   :reset_password_token # Token for password reset.
      t.datetime :reset_password_sent_at # Timestamp when the reset password token was sent.

      ## Rememberable
      t.datetime :remember_created_at # Timestamp for when the user was last remembered.

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false # The number of times the user has signed in.
      t.datetime :current_sign_in_at # Timestamp for the current the user signed in.
      t.datetime :last_sign_in_at  # Timestamp for the last the user signed in.
      t.string   :current_sign_in_ip # IP address of the current sign-in.
      t.string   :last_sign_in_ip # IP address of the last sign-in.

      ## Confirmable
      t.string   :confirmation_token # Token for email confirmation.
      t.datetime :confirmed_at # Timestamp for when the user was confirmed.
      t.datetime :confirmation_sent_at # Timestamp for when the confirmation token was sent.
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts, and Count of failed login attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both, Token for account unlock
      t.datetime :locked_at # Timestamp for when the account was locked

      t.timestamps null: false # Adds 'created_at' and 'updated_at' timestamps.
    end

    add_index :users, :email,                unique: true # This line adds an index to the email column in the users table. The unique: true option ensures that each email must be unique in the users table. This means that no two users can have the same email address.
    add_index :users, :reset_password_token, unique: true # It ensures that each reset password token must be unique in the users table.
    add_index :users, :confirmation_token,   unique: true # It ensures that each confirmation token must be unique in the users table.
    add_index :users, :unlock_token,         unique: true # It ensures that each unlock token must be unique in the users table.
  end
end
