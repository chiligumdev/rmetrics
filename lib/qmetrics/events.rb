# frozen_string_literal: true

module Qmetrics
  # Handles action events across rails
  class Events
    attr_reader :db_client

    def organize_event(event)
      {
        values: {
          name: event.name,
          duration: event.duration
        }
      }
    end

    def notification_subscription(action_name)
      ActiveSupport::Notifications.subscribe(action_name) do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        puts(event.name)
        puts(event)
        @db_client.write_data(action_name, organize_event(event))
      end
    end

    def controller_subscribe_events
      Qmetrics.action_controller.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def record_subscribe_events
      Qmetrics.active_record.each do |action|
        notification_subscription(action.to_s)
      end
    end

    def initialize
      @db_client = Qmetrics::Influx.new(Qmetrics.db_config)
    end
  end
end
