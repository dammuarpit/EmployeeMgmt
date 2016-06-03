require File.expand_path('../boot', __FILE__)

# require 'rails/all'
require "action_controller/railtie"
require "action_mailer/railtie"
#require "active_resource/railtie"
require "rails/test_unit/railtie"
require "sprockets/railtie"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


# add these line for log4r
# require 'log4r'
# require 'log4r/yamlconfigurator'
# require 'log4r/outputter/datefileoutputter'
# require 'log4r/outputter/emailoutputter'
# include Log4r


module EmployeeMgmt
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{Rails.root}/lib/)
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    # assign log4r's logger as rails' logger.
    # log4r_config= YAML.load_file(File.join(File.dirname(__FILE__), 'log4r.yml'))
    # YamlConfigurator['RAILS_ROOT'] = Rails.root.to_s
    # YamlConfigurator['RAILS_ENV'] = Rails.env
    # YamlConfigurator.decode_yaml(log4r_config['log4r_config'])
    #
    # Mongoid.logger = Log4r::Logger['mongoid']
    # Moped.logger = Log4r::Logger['mongoid']

    # disable standard Rails logging
    # config.logger = Log4r::Logger['rails']

    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

  end
end

