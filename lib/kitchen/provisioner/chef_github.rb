require 'kitchen/provisioner/chef_zero'
require 'kitchen-appbundle-updater/helpers'

module Kitchen
  module Provisioner
    class ChefGithub < Kitchen::Provisioner::ChefZero
      default_config :refname, "master"
      default_config :github_owner, "chef"
      default_config :github_repo, "chef"

      def create_sandbox
        super
        dna = {
          chef_appbundle_updater: {
            github_org: config[:github_owner],
            github_repo: config[:github_repo],
            refname: config[:refname]
          }
        }

        File.open(File.join(sandbox_path, 'dna_updater.json'), "wb") do |f|
          f.write(dna.to_json)
        end
      end

      def latest_chef_appbundle_updater
        url = "https://api.github.com/repos/jdmundrawala/chef-appbundle-updater/releases/latest"
        url += "?access_token=#{config[:github_access_token]}" if config[:github_access_token]

        @cookbook_url ||= open(url) do |r|
          j = JSON.parse(r.read)
          j["assets"][0]["browser_download_url"]
        end
      end

      def prepare_command
        [
          prepare_command_vars,
          KitchenAppbundleUpdater::Helpers.load_file("chef_base_updater", powershell_shell?)
        ].join("\n")
      end

      def prepare_command_vars
        vars = [
          shell_var("cookbook_url", latest_chef_appbundle_updater),
          shell_var("json", File.join(config[:root_path], 'dna_updater.json')),
          shell_var("chef_omnibus_root", config[:chef_omnibus_root]),
        ]

        if powershell_shell?
          vars.join("\n")
        else
          vars.join(";\n")
        end
      end

    end
  end
end
