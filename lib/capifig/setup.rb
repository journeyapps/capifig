# Defines capifig:deploy which deploys configuration
require 'capistrano'
require 'capifig/configuration'

module Capifig
  module Setup
    def self.load_into(configuration)
      configuration.load do
        after "deploy:update_code", "capifig:deploy"

        namespace :capifig do
          desc <<-DESC
            TODO: write description here
          DESC
          task :deploy do
            stage = fetch(:stage, 'production')
            config_path = fetch(:config_path, "config/deploy/stages/#{stage}")
            Capifig::Configuration.deploy(configuration, config_path)
            logger.info "Configuration deployment complete."
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  # Automatically load configuration into capistrano, if capistrano is being configured
  Capifig::Setup.load_into(Capistrano::Configuration.instance)
end