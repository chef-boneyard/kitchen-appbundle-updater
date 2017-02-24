require 'kitchen/provisioner/chef_zero'

module Kitchen
  module Provisioner
    class ChefGithub < Kitchen::Provisioner::ChefZero
      default_config :refname, "master"
      default_config :github_owner, "chef"
      default_config :github_repo, "chef"
      default_config :ohai_refname, ""
      default_config :chef_omnibus_url, "https://omnitruck.chef.io/current/install.sh"
      default_config :chef_omnibus_install_options, "-n"

      def prepare_command
        ruby_bin = remote_path_join(config[:ruby_bindir], "ruby").
          tap { |path| path.concat(".exe") if windows_os? }
        gem_bin = remote_path_join(config[:ruby_bindir], "gem").
          tap { |path| path.concat(".bat") if windows_os? }
        appbundle_updater_bin = remote_path_join(config[:ruby_bindir], "appbundle-updater")
          # tap { |path| path.concat(".bat") if windows_os? }
        vars = [
          shell_var("refname", config[:refname]),
          shell_var("github_owner", config[:github_owner]),
          shell_var("github_repo", config[:github_repo]),
          shell_var("ohai_refname", config[:ohai_refname]),
          shell_var("ruby", sudo(ruby_bin)),
          shell_var("gem", sudo(gem_bin)),
          shell_var("appbundle_updater", appbundle_updater_bin),
        ].join("\n").concat("\n")

        my_shell_code_from_file(vars, "chef_base_updater")
      end

      private

      # need to override and use __FILE__ relative to this plugin
      def my_shell_code_from_file(vars, file)
        src_file = File.join(
          File.dirname(__FILE__),
          %w[.. .. .. support],
          file + (powershell_shell? ? ".ps1" : ".sh")
        )

        wrap_shell_code([vars, "", IO.read(src_file)].join("\n"))
      end

    end
  end
end
