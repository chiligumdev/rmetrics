# test/qmetrics/test_events.rb

require 'test_helper'
require 'minitest/autorun'
require 'qmetrics'

# Tests all events handled by Active Support
class TestEvents < Minitest::Test
  # rubocop:disable Metrics/MethodLength
  def setup
    Qmetrics.setup do |config|
      config.action_controller = ['start_processing.action_controller']
      config.active_view = ['render_template.action_view']
      config.active_record = ['sql.active_record']
      config.action_mailer = ['receive.action_mailer']
      config.active_support = ['cache_read.active_support']
      config.active_job = ['enqueue_at.active_job']
      config.action_cable = ['perform_action.action_cable']
      config.active_storage = ['service_upload.active_storage']
      config.db_config = { username: ENV['INFLUX_USER'],
                           password: ENV['INFLUX_PASSWORD'],
                           database: ENV['INFLUX_DATABASE'],
                           host: ENV['INFLUX_HOST'],
                           port: ENV['INFLUX_PORT'], retry: 10 }
    end
    @events = Qmetrics::Events.new
  end
  # rubocop:enable Metrics/MethodLength

  def test_notification_subscription
    event_name = 'hsuahsauhsau'
    subscriber = @events.notification_subscription(event_name)
    assert_equal subscriber.subscribed_to?(event_name), true
    ActiveSupport::Notifications.unsubscribe(event_name)
  end

  def test_controller_subscribe_events
    actions_subs = @events.controller_subscribe_events
    Qmetrics.action_controller.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_view_subscribe_events
    actions_subs = @events.view_subscribe_events
    Qmetrics.active_view.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_record_subscribe_events
    actions_subs = @events.record_subscribe_events
    Qmetrics.active_record.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_mailer_subscribe_events
    actions_subs = @events.mailer_subscribe_events
    Qmetrics.action_mailer.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_support_subscribe_events
    actions_subs = @events.support_subscribe_events
    Qmetrics.active_support.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_job_subscribe_events
    actions_subs = @events.job_subscribe_events
    Qmetrics.active_job.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_cable_subscribe_events
    actions_subs = @events.cable_subscribe_events
    Qmetrics.action_cable.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_storage_subscribe_events
    actions_subs = @events.storage_subscribe_events
    Qmetrics.active_storage.each do |action|
      assert_equal actions_subs.include?(action), true
      ActiveSupport::Notifications.unsubscribe(action)
    end
  end

  def test_organize_event
    event = ActiveSupport::Notifications::Event.new('test', Time.now,
                                                    Time.now, 'auhsuahsua',
                                                    payload: { name: 'test' })
    org_event = @events.send(:organize_event, event)
    assert_equal event.duration, org_event[:values][:duration]
    assert_equal event.payload[:payload], org_event[:values][:payload]
  end
end
