require_relative 'boot'

require 'rails/all'
require 'pp'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wink
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Berlin'

    # config.eager_load_paths << Rails.root.join("extras")

    # il8n config
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]

    config.i18n.default_locale = :de

    # set the application name and slogan
    config.application_name = 'WINK'
    config.application_slogan = '(W)o (i)st mei(n)e Winke(k)atze?'

    unless Pathname(Rails.root + 'config/mqtt.yml').exist?
      FileUtils.cp(Pathname(Rails.root + 'config/mqtt.yml.template'), Pathname(Rails.root + 'config/mqtt.yml'))
      puts "Copied #{Pathname(Rails.root + 'config/mqtt.yml.template')} to #{Pathname(Rails.root + 'config/mqtt.yml.template')}"
    end

    config.mqtt = config_for(:mqtt)

  end
end
