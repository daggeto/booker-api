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

    config.autoload_paths << Rails.root.join('interactors')
  end
end
