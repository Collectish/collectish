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

module Collectish
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    #Use Redis as the Rails cache
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 2.hours}
    #Use Redis as the session store
    config.session_store :redis_store, {
      servers: [
        {
          host: "localhost",
          port: 6379,
          db: 0,
        },
      ],
      expire_after: 2.hours,
      key: "_#{Rails.application.class.parent_name.downcase}_session"
    }
  end
end
