require 'kitchen/provisioner/chef_zero'
require 'kitchen-appbundle-updater/helpers'

module Kitchen
  module Provisioner
    class ChefGithub < Kitchen::Provisioner::ChefZero
      default_config :chef_gitref, "master"
      default_config :chef_gitorg, "chef"
      default_config :chef_gitrepo, "chef"

      def prepare_command
        [
          prepare_command_vars,
          KitchenAppbundleUpdater::Helpers.load_file("chef_base_updater", powershell_shell?)
        ].join("\n")
      end

      def prepare_command_vars
        vars = [
          shell_var("gitref", config[:chef_gitref]),
          shell_var("gitorg", config[:chef_gitorg]),
          shell_var("gitrepo", config[:chef_gitrepo]),
          shell_var("chef_omnibus_root", config[:chef_omnibus_root]),
        ]
        if powershell_shell?
          (vars + prepare_command_vars_for_powershell).join("\n")
        else
          (vars + prepare_command_vars_for_sh).join(";\n")
        end
      end

      def prepare_command_vars_for_powershell
        [
          shell_var("gitdir", "$env:TEMP\\"),
        ]
      end

      def prepare_command_vars_for_sh
        [
          shell_var("gitdir", "/tmp/"),
          shell_var("sudo_sh", sudo("sh")),
        ]
      end
    end
  end
end
