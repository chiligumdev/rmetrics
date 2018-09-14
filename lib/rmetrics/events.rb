# frozen_string_literal: true

module Rmetrics
  # Handles action events across rails
  class Events
    attr_reader :db_client

    def initialize
      @db_client = Rmetrics::Influx.new(Rmetrics.db_config)
    end

    def notification_subscription(action_name)
      ActiveSupport::Notifications.subscribe(action_name) do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        @db_client.write_data(action_name, organize_event(event))
      end
    end

    def controller_subscribe_events
      Rmetrics.action_controller.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def view_subscribe_events
      Rmetrics.active_view.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def record_subscribe_events
      Rmetrics.active_record.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def mailer_subscribe_events
      Rmetrics.action_mailer.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def support_subscribe_events
      Rmetrics.active_support.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def job_subscribe_events
      Rmetrics.active_job.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def cable_subscribe_events
      Rmetrics.action_cable.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def storage_subscribe_events
      Rmetrics.active_storage.each do |action|
        notification_subscription(action.to_s)
      end
    end

    private

    def organize_event(event)
      act = {
        values: {
          duration: event.duration
        }
      }
      act[:values].merge!(event.payload)
      act
    end
  end
end
