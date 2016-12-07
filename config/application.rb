require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module AuthChallenge
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app', 'validators')
  end
end
