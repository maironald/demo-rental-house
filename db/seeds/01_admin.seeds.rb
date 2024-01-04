# frozen_string_literal: true

puts 'Create admin user'


User.create! do |user| # this line indicates the creation of new "User" record in database. The "!" after "create" indicates that an exception should be raised if the record creations fail.
  user.email = 'admin@jacky.com' # set the email attribute of the user to admin@jacky.com
  user.password = '12345678' # Sets the password attribute of the user to '12345678'. This is the password that the user will use for authentication.
  user.confirmed_at = Time.current # Sets the `confirmed_at` attribute of the used to the current time. This is often used in applications that require email confirmation. By setting this attribute, the user is considered confirmed.
  user.add_role :admin # Assigns the 'admin' role to the user. This assumes that the 'User' model is using the Rolify gem for role management. The 'add_role' method is provided by Rolify to associate roles with users.
end
