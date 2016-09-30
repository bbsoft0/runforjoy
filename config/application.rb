require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Runforjoy
  class Application < Rails::Application
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.autoload_paths += %W(#{config.root}/lib)
    config.eager_load_paths << "#{Rails.root}/lib"
    config.serve_static_assets = true
  end
end
