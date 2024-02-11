# Rental House

Rental House is an online project management about room for rent of house.

## Features

- User can register/update account.
- User can update the user profile information.
- User can create/update/delete rooms.
- User can create/update/delete renter in rooms.
- User can create/update/delete services of the rooms (this services is externally generated services)
- User can update electric and water amount of each room.
- User can update the price of electric (1kwh), water (1m3), internet, security, garbage.
- User can see the statistic about total of the profits and expenses (by month).
- User can create/update/delete invoices of each room.
- User can search, filter of each room, renter, service,...
- Admin can update password of user account, deactived/actived or remove permanently the user account.
- Admin can notice User when update/create events by notifications.

## General Information

- [Ruby]: (v3.2.2) - A dynamic, open source programming language.
- [Ruby on Rails]: (v7.0.6) - A full-stack framework, ships with all the tools needed.
- [PostgreSQL] (v1.1) - A powerful, open source object-relational database system.
- [TailwindCSS] (v3.4.0) - The utility-first CSS framework that provides low-level utility classes to style your HTML elements directly.
- [StimulusJS] (v3.2.2) - A modest JavaScript framework for the HTML you already have.
- [Redis] (v4.0) - The open source, in-memory data store used by millions of developers as a database, cache, streaming engine, and message broker.
- [Cloudinary] (v1.28) - Streamline media management and improve user experience by automatically delivering images and videos, enhanced and optimized for every user.

## Installation

- Install the correct ruby version: `asdf local ruby 3.2.2`
- Install Node.js (> v8.16.0) and Yarn
- Install Redis server
- Install Rails: `gem install rails -v 7.0.6`
- Install bundler: `gem install bundler`
- Install gems: `bundle install`
- Config database at `config/database.yml`
- Add `.env` file
- Setup database: `rails db:setup`
- Start redis server
- Start web server: `rails server`
- Start vite server: `vite dev`

## Deploy

Host in Render: <https://rental-house-gdnc.onrender.com>

## 📌 Database Diagram

Link: <https://www.mermaidchart.com/raw/001504e7-edfc-45ff-9ac4-c82c92787e0e?theme=light&version=v0.1&format=svg>

## 📌 Project structure

```text
Rental House Project
├─ app
│  ├─ channels
│  ├─ controllers
│  │  ├─ admin
│  │  ├─ concerns
|  |  └─ users
│  ├─ frontend
|  |  ├─ channels
|  |  ├─ controllers
|  |  |  ├─ admins
|  |  |  ├─ chart
|  |  |  ├─ rooms
|  |  |  ├─ shared
|  |  |  └─ users
|  |  ├─ entrypoints
|  |  ├─ images
|  |  |  ├─ dashboard
|  |  |  ├─ footer
|  |  |  ├─ icons
|  |  |  ├─ logo
|  |  |  ├─ navigation
|  |  |  └─ room
|  |  ├─ stylesheets
|  |  |  ├─ components
|  |  |  ├─ pages
|  |  |  └─ users
│  ├─ helpers
|  |  └─ builders
│  ├─ jobs
│  ├─ mailers
│  ├─ models
|  |  └─ concerns
│  ├─ notifiters
│  ├─ policies
│  ├─ uploaders
│  └─ views
│  │  ├─ admins
│  │  │  └─ dashboard
│  │  ├─ devise
│  │  │  ├─ confirmations
│  │  │  ├─ mailer
│  │  │  ├─ passwords
│  │  │  ├─ registrations
│  │  │  ├─ sessions
│  │  │  ├─ shared
│  │  │  └─ unlocks
│  │  ├─ electric_waters
│  │  ├─ home
│  │  ├─ invoices
│  │  ├─ layouts
│  │  ├─ notifications
│  │  ├─ pages
│  │  ├─ renters
│  │  ├─ rooms
│  │  ├─ services
│  │  ├─ settings
│  │  ├─ shared
│  │  ├─ users
│  │  │  └─ dashboard
├─ bin
├─ config
│  ├─ environments
│  ├─ initializers
│  └─ locales
├─ db
│  ├─ migrate
│  ├─ seeds
│  └─ locales
├─ lib
│  ├─ assets
│  └─ tasks
├─ log
├─ public
├─ spec
│  ├─ channels
│  ├─ controllers
│  ├─ models
├─ storage
├─ test
├─ tmp
├─ vendor
```

[Ruby]: https://www.ruby-lang.org/en/
[Ruby on Rails]: https://rubyonrails.org/
[PostgreSQL]: https://www.postgresql.org/
[TailwindCSS]: https://tailwindcss.com/docs/installation/
[StimulusJs]: https://stimulus.hotwired.dev/
[Redis]: https://redis.io/
[Cloudinary]: https://cloudinary.com/
