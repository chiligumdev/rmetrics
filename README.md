# Rmetrics

Rmetrics is a gem that relies on ActiveSupport to get all metrics in your Rails application, such as: ActionController, ActiveView, ActiveRecord, ActionMailer, ActiveSupport, ActiveJob, ActionCable and ActiveStorage

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rmetrics'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rmetrics

## Usage

To start get all the metrics you want, you have to call Rmetrics.setup inside a file in config/initializers/rmetrics.rb.
One example of how you should setup rmetrics is below:

```ruby
Rmetrics.setup do |config|
  config.action_controller = ['start_processing.action_controller',
                              'process_action.action_controller',
                              'redirect_to.action_controller']
  config.active_view = ['render_template.action_view',
                        'render_partial.action_view']
  config.active_record = ['instantiation.active_record',
                          'sql.active_record']
  config.action_mailer = ['receive.action_mailer']
  config.active_support = ['cache_read.active_support']
  config.active_job = ['enqueue_at.active_job']
  config.action_cable = ['perform_action.action_cable']
  config.active_storage = ['service_upload.active_storage']
  config.db_config = { username: ENV['INFLUX_USERNAME'],
                       password: ENV['INFLUX_PASSWORD'],
                       database: ENV['INFLUX_DATABASE'],
                       host: ENV['INFLUX_HOST'],
                       port: ENV['INFLUX_PORT'], retry: 10 }
end
```

After that, you have to subscribe to all Action or Active you want, one example is given below:

```ruby
events = Rmetrics::Events.new
events.controller_subscribe_events
events.record_subscribe_events
events.view_subscribe_events
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chiligumdev/rmetrics. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rmetrics project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/chiligumdev/rmetrics/blob/master/CODE_OF_CONDUCT.md).
