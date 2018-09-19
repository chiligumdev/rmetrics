require 'influxdb'

module Rmetrics
  # Handles the comunnication to Influx DB
  class Influx
    def initialize(options = {})
      @influx_client = InfluxDB::Client.new(options)
    end

    def write_data(table, data)
      @influx_client.write_point(table, organize_event(data))
    end

    private

    def adjust_values(act, payload)
      payload.each do |key, value|
        if value.is_a?(Hash) || value.is_a?(Array)
          act[key] = value
        else
          act[:values].merge!(key: value)
        end
      end
    end

    def organize_event(event)
      act = {
        values: {
          duration: event.duration
        }
      }
      adjust_values(act, event.payload)
      act
    end
  end
end
