require 'influxdb'

module Rmetrics
  # Handles the comunnication to Influx DB
  class Influx
    def initialize(options = {})
      @influx_client = InfluxDB::Client.new(options)
    end

    def write_data(table, data)
      @influx_client.write_point(table, data)
    end
  end
end
