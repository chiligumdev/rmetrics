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

    # rubocop:disable Metrics/MethodLength
    def adjust_values(act, payload)
      payload.each do |key, value|
        case value
        when Hash
          act[:tags].merge!(value.select { |_, v| v.is_a?(String) })
        when Numeric || Integer || String || TrueClass || FalseClass
          act[:values][key.to_sym] = value
        when Symbol
          act[:values][key.to_sym] = value.to_s
        else
          next
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def organize_event(event)
      act = {
        values: {
          duration: event.duration
        },
        tags: {
          name: event.name
        }
      }
      adjust_values(act, event.payload)
      act
    end
  end
end
