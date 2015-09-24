require 'kitchen/provisioner/chef_zero'
require 'kitchen-appbundle-updater/helpers'

module Kitchen
  module Provisioner
    class ChefGithub < Kitchen::Provisioner::ChefZero
      default_config :refname, "master"
      default_config :github_owner, "chef"
      default_config :github_repo, "chef"

      def prepare_command
        gem_bin = remote_path_join(config[:ruby_bindir], "gem").
          tap { |path| path.concat(".bat") if windows_os? }
        vars = [
          chef_client_zero_env,
          shell_var("refname", config[:refname]),
          shell_var("github_owner", config[:github_owner]),
          shell_var("github_repo", config[:github_repo]),
          shell_var("gem", sudo(gem_bin)),
        ].join("\n").concat("\n")

        shell_code_from_file(vars, updater_script)
      end

      private

      def updater_script(file, is_powershell)
        File.join(
          File.dirname(__FILE__),
          %w[.. .. support],
          "chef_base_updater" + (powershell_shell? ? ".ps1" : ".sh")
      end

    end
  end
end
