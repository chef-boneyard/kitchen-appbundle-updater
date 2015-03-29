module Kitchen
  module Provisioner
    class ChefGithub
      default_config :chef_gitref, "master"

      def prepare_command
        [
          prepare_command_vars_for_powershell,
          KitchenAppbundleUpdater::Helpers.load_file("chef_base_updater", powershell_shell?)
        ].join("\n")
      end

      def prepare_command_vars_for_powershell(version)
        [
          shell_var("gitref", config[:chef_gitref]),
          shell_var("gitdir", "$env:TEMP\\github")
        ].join("\n")
      end
    end
  end
end
