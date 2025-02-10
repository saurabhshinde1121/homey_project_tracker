# README

## Dependencies
* Ruby version : 3.2.4
* Rails Version : 7.1.5

## Setup and start the applicaton

### Install Dependencies
```
$ gem install bundler && bundle install
```

### Setup database
```
$ rails db:create db:migrate && rake db:seed
```

### Run the server
```
$ rails s
```

### Run the Test Suit
```
$ bundle exec rspec
```

### Run the rubocop
```
$ bundle exec rubocop
```

## Future Enhancements
* Add state machine for project status and also add proper state transitions to validate from which state to which state the project can be transitioned.
* Project Event History should be enabled for other event types as well.
* Send email notifications on project events to the project assignee, implement sidekiq background jobs for the same.
* Add images/documents/code to comment section or Add WYSWIG editor to the comments section.
* Use proper deployment technique, as of now used free version.
* Using internationalisation gem I18n for translating application to a single custom language.
* Implement User authorization based on roles using cancan / pundit gem.
* Used sqlite3 to avoid cost of server under deployment
