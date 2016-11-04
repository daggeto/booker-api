require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookerApi
  class Application < Rails::Application
    config.api_only = true
    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :put, :delete, :post, :options]
      end
    end

    config.secret_key_base = Rails.application.secrets.secret_key_base

    config.autoload_paths << Rails.root.join('interactors', 'personalizers', 'searches', 'domain')
    config.autoload_paths += %W(
      #{config.root}/lib
    )

    config.i18n.available_locales = ['en-US', 'lt']
    I18n.config.enforce_available_locales = false
    I18n.default_locale = ENV.fetch('APP_LOCALE', 'en-US')
    I18n.locale = ENV.fetch('APP_LOCALE', 'en-US')

    config.time_zone = 'Vilnius'
    config.active_record.default_timezone = :utc

  end
end
