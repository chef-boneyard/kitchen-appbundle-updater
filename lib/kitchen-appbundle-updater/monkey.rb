require 'kitchen/provisioner/chef_base'
require 'kitchen-appbundle-updater/helpers'

class Kitchen::Provisioner::ChefBase

  default_config :chef_gitref, "master"

  alias _install_command install_command
  def install_command
    [_install_command, KitchenAppbundleUpdater::Helpers.load_file("chef_base_updater", powershell_shell?)].join("\n")
  end

  alias _install_command_vars_for_powershell install_command_vars_for_powershell
  def install_command_vars_for_powershell(version)
    [
      _install_command_vars_for_powershell(version),
      shell_var("gitref", config[:chef_gitref]),
      shell_var("gitdir", "$env:TEMP\\github")
    ].join("\n")
  end


end
