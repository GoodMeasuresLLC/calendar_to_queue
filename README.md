# CalendarToQueue

Mountable endpoint for Calendar Push Notifications from Google Calenders that
are placed into AWS Message Queues or a database for consumption.

Google Calendar Push notifications can only be sent to verified domains over
HTTPS.  Your HTTPS domain must have a valid certificate.  Invalid certificates
include:

- Self-signed certificates.
- Certificates signed by an untrusted source.
- Certificates that have been revoked.
- Certificates that have a subject that doesn't match the target hostname.

This mountable rails engine can be hosted on a valid SSL domain and distribute
Google Calendar Push notifications for different Rails environments, which may
not have SSL available, such as your local development environment.

# Installation

## General Installation

1 - Add to your Gemfile:

```ruby
gem 'calendar-to-queue'
```

2 - Install the gem:

```bash
bundle install
```

3 - Install Migrations

```bash
$ rake calendar_to_queue:install:migrations
$ rake db:migrate
```

4 - Mount the engine

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount CalendarToQueue::Engine, at: "/"
end
```

5 - Configure AWS Credentials and Region

```ruby
# config/initializers/calendar_to_queue.rb
CalendarToQueue.configure do |config|
  config.aws_access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  config.aws_region            = 'us-east-1'
end
```

# Watching Calendar Resources

When a push notification is recieved from Google Calendars, the push will be
processed based on parameters in the token provided when the calendar resource
was watched. Two behaviors are implemented: persist the pushes to the database
and send the push to AWS Simple Queue Service.

## Persist

To persist a push, set the following in the token:

```
persist=true
```

## Send to AWS SQS

To send a push to AWS SQS, set the following in the token:

```
queue=<aws-queue-name>
```

If the queue does not exist in the region specified, it will be created.

# Resources

- [Google Calendar API Overview](https://developers.google.com/google-apps/calendar/overview)
- [Google Calendar Push Notifications](https://developers.google.com/google-apps/calendar/v3/push)
- [AWS SQS Ruby Client](https://docs.aws.amazon.com/sdkforruby/api/Aws/SQS.html)

# TODO

- Examples of SQS message format
- Link to sample application code
- Remove authentication & authorization configuration
- Examples of how to wire into after-save callbacks on persisted pushes for immediate processing
- Document logging

# Contributors

- [John Naegle](https://github.com/johnnaegle)

## License

MIT License. Copyright 2016.
