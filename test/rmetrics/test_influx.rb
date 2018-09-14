# test/rmetrics/test_events.rb

require 'test_helper'
require 'minitest/autorun'
require 'rmetrics'
# Test Influxdb class
class TestInflux < Minitest::Test
  def setup
    influx_options = { username: ENV['INFLUX_USER'],
                       password: ENV['INFLUX_PASSWORD'],
                       database: ENV['INFLUX_DATABASE'],
                       host: ENV['INFLUX_HOST'],
                       port: ENV['INFLUX_PORT'], retry: 10 }
    @influx_client = Rmetrics::Influx.new(influx_options)
  end

  def test_write_data
    response = @influx_client.write_data('test', values: { test: 'test' })
    assert_equal response.code, '204'
  end
end
