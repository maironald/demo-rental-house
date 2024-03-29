# Knowledge about rails 7

This Knowledge would normally document for you to read all the knowledge in the project.

link Simple Form: <https://github.com/heartcombo/simple_form>

- run the db seed by: rails db:seed:<file_name> . Ex: rails db:seed:03_rooms

- Devise Helpers: rails generate devise:views => this code will create all the folder about the devise which you need in folder views.

  - :database_authenticatable: Handles authentication through a username/email and password.
  - :registerable: Allows users to register and includes actions for user registration.
  - :recoverable: Provides password reset functionality.
  - :rememberable: Manages generating and clearing a token for remembering the user from a saved cookie.
  - :validatable: Adds validations to the User model, such as email and password presence.
  - :confirmable: Handles user email confirmation.
  - :lockable: Locks an account after a certain number of failed login attempts.
  - :timeoutable: Times out a session after a specified time of inactivity.
  - :trackable: Tracks sign-in count, timestamps, and IP address.

- Folder in Devise:

  - password/edit.html.erb: recover the password when you forget it
  - password/new.html.erb: Check the email already in the database.
  - registrations/edit.html.erb: Check the email

- if you want to see all the notification about devise, you can go to the config/locales/devise.en.yml to see the content.

- Migration:

  - You can create a file migrate with: rails generate migration <file_name> <attribute:type> Ex: rails generate migration add_name_address_phonenumber_to_users name:string age:integer

  - Note: you can drop table by using rails c with "ActiveRecord::Migration.drop_table :room_services"

- Rendering the layouts:

  - link_to: using to create a hyperlinks in HTML.
    - Ex: <%= link_to "Xem chi tiết", article_path(@article) %>
  - button_to: using to create the buttons in form HTML to do HTTP methods.
    - Ex: <%= button_to "Xóa", article_path(@article), method: :delete, data: { confirm: "Bạn có chắc muốn xóa bài viết này không?" } %>
  - redirect_to: using to send an HTTP redirect status code to the browser.
    - Ex: <% redirect_to articles_path, notice: "Bài viết đã đượ tạo thành công." %>
  - render: using to create a full response to send back to the browser.
    - Ex: <% render "path_na&.: This is the "safe navigation" or "lonely operator." It allows you to call a method on an object without raising an error if the object is nil. If current_user is nil, the entire expression will return nil without raising an error.me" %>

- &.: This is the "safe navigation" or "lonely operator." It allows you to call a method on an object without raising an error if the object is nil. If current_user is nil, the entire expression will return nil without raising an error.

- If you want to create controllers about devise in users, you can code: rails g devise:controllers users .

- Google OAuth: EDITOR="code --wait" bin/rails credentials:edit => in this file, we can add more credentials key such as google_client_id, google_client_secret,...

- resource vs resources in route config

  - resource:
    - Used when working with a singular resource, meaning there is only one instance of the resource.
    - Does not include an index route because there is only one resource.
    - The resource identifier is singular (no "s" at the end).
    - Ex: resource :profile
      - GET /profile/new
      - POST /profile
      - GET /profile
      - GET /profile/edit
      - PATCH /profile
      - PUT /profile
      - DELETE /profile
  - resources:
    - Used when working with multiple instances of a resource.
    - Creates routes similar to resource, but includes an additional index route to display a list of all resources.
    - The resource identifier is plural (with an "s" at the end).
    - Ex: resources :articles
      - GET /articles
      - GET /articles/new
      - POST /articles
      - GET /articles/:id
      - GET /articles/:id/edit
      - PATCH /articles/:id
      - PUT /articles/:id
      - DELETE /articles/:id

- NOTE: when working with Ruby

  - No using disable with rubocop. Ex: No using # rubocop:disable Rail HasManyOrHasOneDependent

- Running a migration's down method is typically done by rolling back the migration using the db:rollback :
  - EX: rails db:rollback STEP=1

## Many_to_many

- Example: room - has many - service and service - has many - room.

  - you can create model by (it will auto generate migration):
    - rails g model Room <attribute_name>
    - rails g model Service string:name decimal:price text:note <attribute_name>
    - rails g model RoomService
  - After that, in migration room_service, you can type two keys references:
    - t.belongs_to :room
    - t.belongs_to :service
  - Then you can add these instructions below to room model:
    - has_many :room_services, dependent: :destroy
      has_many :services, through: :room_services
  - And add these instructions below to service model:
    - has_many :room_services, dependent: :destroy
      has_many :rooms, through: :room_services
  - Finally add these instructions to room_service model:
    - belongs_to :room
      belongs_to :service

- Note: you just should rails g migration <name_migration_file> => in case: you want to change/update the table in postgreSQL

## Simple form

- Example:
- <%= simple_form_for @room, method: :post, url: add_services_to_room_room_path() do |f| %>
    <!-- other form fields -->

  <%= f.collection_check_boxes :service_ids, current_user.services.all, :id, :name, include_hidden: false, wrapper_html: {class: 'mb-4'}, collection_html: {class: 'p-4'}, span_html: {class: 'mb-2 text-white text-[10px] flex'} do |b| %>
  <div>
  <%= b.check_box %>
  <%= b.label %>
  </div>

  <% end %>

  <%= f.button :submit, "Xác nhận" %>
    <div class="flex justify-between">
      <%= link_to 'Trở về', rooms_path%>
    </div>
  <% end %>

## Knowledge about Stimulus

- Link reference: <https://stimulus.hotwired.dev/handbook/hello-stimulus>

- Stimulus: => Javascript framework which is designed to enhance static or server-rendered HTML—the “HTML you already have”

  - These JavaScript objects are called controllers.
  - Aside from controllers, the three other major Stimulus concepts are
    - actions: which connect controller methods to DOM events using data-action attributes.
    - targets: which locate elements of significance within a controller.
    - value: which read, write, and observe data attributes on the controller's element.
  - Method popular:
    - connect() method, which Stimulus calls each time a controller is connected to the document.
  - Default events for action:
    - a: click
    - button: click
    - details: toggle
    - form: submit
    - input: input
    - input type=submit: click
    - select: change
    - textarea: input
  - Lifecycle callbacks:
    - initialize() : Once, when the controller is first instantiated
    - connect(): Anytime the controller is connected to the DOM
    - disconnect(): Anytime the controller is disconnected from the DOM.

## Knowledge about Turbo

- turbo_stream:

  - Use turbo.stream when you want to change or add multiple elements in the Turbo Frame, not just the first element
  - Ex: When you perform an action and want to update the entire list or elements in a specific part of the page, you can use turbo.stream to change multiple element.
    format.turbo_stream do
    render turbo_stream.update('my_frame', partial: 'items/list', locals: { items: @updated_items })
    end

- turbo.prepend:

  - Using turbo.prepend when you want to add a new element to the first index of the list in the Turbo Frame.
  - This is often used when there is a new event and you want to insert it at the beginning of the list without having to reload the entire list.
  - Ex: Add a new comment to the first index of the list comment.
    format.turbo_stream do
    render turbo_stream.prepend('comments_frame', partial: 'comments/comment', locals: { comment: @new_comment })
    end

- turbo.replace:

  - Using 'turbo.replace' when you want to replace all the content of Turbo Frame with a new content.
  - This usually uses when you want to reload all the content in Turbo Frame.
  - Ex: When you want to act, and replace all the list or content in Turbo Frame.
    format.turbo_stream do
    render turbo_stream.replace('items_frame', partial: 'items/list', locals: { items: @updated_items })
    end

## Knowledge about gem Pagy

- <https://github.com/ddnexus/pagy?tab=readme-ov-file>
- Note: you can customize css by using tailwind css (see file pagy.scss)

## Knowledge about gem Notifier

see video at: <https://www.youtube.com/watch?v=SzX-aBEqnAc>

- install the gem notification: "bundle add noticed"
- Generate then run the migrations: "rails noticed:install:migrations" and "rails db:migrate"
- Generate Notifier: "rails generate noticed:notifier NewCommentNotifier"
- In Migration, it will create 2 tables: noticed_events and noticed_notifications

  - noticed_events: represents an event in your application. For example: when you create a notification, you can specify the type of event, the source of event, and any attached data (payload).
  - noticed_notification: represents a notification to a user. When you want to send a notification to user, you create an instance of "Noticed:Notification" and associate it with a "Noticed::Event". For example: when you have created "Noticed::Event" done, it will define whom you want to send the notification to.

- In file "new_comment_notifier": you can add "config.params = -> (recipient) {{user: recipient }}" into deliver_by.

- You need add the record and recipient like this into the User Model:

  - has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  - has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

- And need add the record like this into Notification Model:

  - has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

- After that, you go to "rails c" and create the first notifications with the code "NewCommentNotifier.with(record: @post, message: "New post").deliver(User.all)" (in that: message is params) ,
- Another way you can do: "NewCommentNotifier.with(record: @post, foo: :bar ).deliver(User.all)" (in that: foo is params) => this is another way but it will save in db like below:

  - {
    "foo": {
    "value": "bar",
    "\_aj_serialized": "ActiveJob::Serializers::SymbolSerializer"
    },
    "\_aj_symbol_keys": [
    "foo"
    ]
    }
  - {
    "message": "New post",
    "\_aj_symbol_keys": [
    "message"
    ]
    }

## Cloudinary

Link reference about gem cloudinary: <https://github.com/cloudinary/cloudinary_gem?tab=readme-ov-file>

Link reference about cloudinary with Ruby/Rails SDK: <https://cloudinary.com/documentation/rails_integration#landingpage>

## Paranoia

Link reference about paranoia: <https://github.com/rubysherpas/paranoia>

## Realtime Notification with ActionCable

## Factory Bot with Faker

- "rails generate channel Notifications": to create a channel

- Then type "Comment.last.notification_mentions"

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
