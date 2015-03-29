require 'kitchen/provisioner/chef_zero'
require 'kitchen-appbundle-updater/helpers'

module Kitchen
  module Provisioner
    class ChefGithub < Kitchen::Provisioner::ChefZero
      default_config :chef_gitref, "master"

      def prepare_command
        [
          prepare_command_vars_for_powershell,
          KitchenAppbundleUpdater::Helpers.load_file("chef_base_updater", powershell_shell?)
        ].join("\n")
      end

      def prepare_command_vars_for_powershell
        [
          shell_var("gitref", config[:chef_gitref]),
          shell_var("gitdir", "$env:TEMP\\"),
          shell_var("chef_omnibus_root", config[:chef_omnibus_root]),
        ].join("\n")
      end
    end
  end
end
