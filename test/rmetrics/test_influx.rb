# test/rmetrics/test_events.rb

require 'test_helper'
require 'minitest/autorun'
require 'rmetrics'

# Test Influxdb class
class TestInflux < Minitest::Test
  # rubocop:disable Metrics/MethodLength
  def setup
    influx_options = { username: ENV['INFLUX_USER'],
                       password: ENV['INFLUX_PASSWORD'],
                       database: ENV['INFLUX_DATABASE'],
                       host: ENV['INFLUX_HOST'],
                       port: ENV['INFLUX_PORT'], retry: 10 }
    @influx_client = Rmetrics::Influx.new(influx_options)
    @payload = {
      controller: 'Devise::SessionsController',
      action: 'new',
      params: { action: 'new', controller: 'devise/sessions' },
      format: :html,
      method: 'GET',
      path: '/login/sign_in',
      status: 200,
      view_runtime: 279.3080806732178,
      db_runtime: 40.053
    }
  end
  # rubocop:enable Metrics/MethodLength

  def test_write_data
    event = ActiveSupport::Notifications::Event.new('test', Time.now, Time.now,
                                                    'test', @payload)
    response = @influx_client.write_data('test', event)
    assert_equal response.code, '204'
  end
end
