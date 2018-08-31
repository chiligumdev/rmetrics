require 'rails'

module Qmetrics
  # Defines what kind of metric should catch inside ActionController
  mattr_accessor :action_controller
  @@action_controller = ['start_processing.action_controller']

  # Defines what kind of metric should catch inside ActiveView
  mattr_accessor :active_view
  @@active_view = []

  # Defines what kind of metric should catch inside ActiveRecord
  mattr_accessor :active_record
  @@active_record = ['sql.active_record']

  # Defines what kind of metric should catch inside ActionMailer
  mattr_accessor :action_mailer
  @@action_mailer = []

  # Defines what kind of metric should catch inside ActiveSupport
  mattr_accessor :active_support
  @@active_support = []

  # Defines what kind of metric should catch inside ActiveJob
  mattr_accessor :active_job
  @@active_job = []

  # Defines what kind of metric should catch inside ActionCable
  mattr_accessor :action_cable
  @@action_cable = []

  # Defines what kind of metric should catch inside ActiveStorage
  mattr_accessor :active_storage
  @@active_storage = []

  def self.setup
    yield self
  end
end
