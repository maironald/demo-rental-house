# Knowledge

This Knowledge would normally document for you to read all the knowledge in the project.

* run the db seed by: rails db:seed:<file_name> . Ex: rails db:seed:03_rooms

* Devise Helpers: rails generate devise:views => this code will create all the folder about the devise which you need in folder views.

  * :database_authenticatable: Handles authentication through a username/email and password.
  * :registerable: Allows users to register and includes actions for user registration.
  * :recoverable: Provides password reset functionality.
  * :rememberable: Manages generating and clearing a token for remembering the user from a saved cookie.
  * :validatable: Adds validations to the User model, such as email and password presence.
  * :confirmable: Handles user email confirmation.
  * :lockable: Locks an account after a certain number of failed login attempts.
  * :timeoutable: Times out a session after a specified time of inactivity.
  * :trackable: Tracks sign-in count, timestamps, and IP address.

* Folder in Devise:
  * password/edit.html.erb: recover the password when you forget it
  * password/new.html.erb: Check the email already in the database.
  * registrations/edit.html.erb: Check the email

* if you want to see all the notification about devise, you can go to the config/locales/devise.en.yml to see the content.

* Migration:
  * You can create a file migrate with: rails generate migration <file_name> <attribute:type> Ex: rails generate migration add_name_address_phonenumber_to_users

* Rendering the layouts:
  * link_to: using to create a hyperlinks in HTML.
    * Ex: <%= link_to "Xem chi tiết", article_path(@article) %>
  * button_to: using to create the buttons in form HTML to do HTTP methods.
    * Ex: <%= button_to "Xóa", article_path(@article), method: :delete, data: { confirm: "Bạn có chắc muốn xóa bài viết này không?" } %>
  * redirect_to: using to send an HTTP redirect status code to the browser.
    * Ex:  <% redirect_to articles_path, notice: "Bài viết đã đượ tạo thành công." %>
  * render: using to create a full response to send back to the browser.
    * Ex: <% render "path_na&.: This is the "safe navigation" or "lonely operator." It allows you to call a method on an object without raising an error if the object is nil. If current_user is nil, the entire expression will return nil without raising an error.me" %>

* &.: This is the "safe navigation" or "lonely operator." It allows you to call a method on an object without raising an error if the object is nil. If current_user is nil, the entire expression will return nil without raising an error.

* If you want to create controllers about devise in users, you can code: rails g devise:controllers users .

* Google OAuth: EDITOR="code --wait" bin/rails credentials:edit => in this file, we can add more credentials key such as google_client_id, google_client_secret,...

* resource vs resources in route config
  * resource:
    * Used when working with a singular resource, meaning there is only one instance of the resource.
    * Does not include an index route because there is only one resource.
    * The resource identifier is singular (no "s" at the end).
    * Ex: resource :profile
      * GET      /profile/new
      * POST     /profile
      * GET      /profile
      * GET      /profile/edit
      * PATCH    /profile
      * PUT      /profile
      * DELETE   /profile
  * resources:
    * Used when working with multiple instances of a resource.
    * Creates routes similar to resource, but includes an additional index route to display a list of all resources.
    * The resource identifier is plural (with an "s" at the end).
    * Ex: resources :articles
      * GET      /articles
      * GET      /articles/new
      * POST     /articles
      * GET      /articles/:id
      * GET      /articles/:id/edit
      * PATCH    /articles/:id
      * PUT      /articles/:id
      * DELETE   /articles/:id

* NOTE: when working with Ruby
  * No using disable with rubocop. Ex: No using # rubocop:disable Rail HasManyOrHasOneDependent

* Running a migration's down method is typically done by rolling back the migration using the db:rollback :
  * EX: rails db:rollback STEP=1

* Stimulus: => Javascript framework which is designed to enhance static or server-rendered HTML—the “HTML you already have”
  * These JavaScript objects are called controllers.
  * Aside from controllers, the three other major Stimulus concepts are
    * actions: which connect controller methods to DOM events using data-action attributes.
    * targets: which locate elements of significance within a controller.
    * value: which read, write, and observe data attributes on the controller's element.

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
