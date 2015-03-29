require 'kitchen/provisioner/chef_base'
require 'kitchen-appbundle-updater/helpers'

class Kitchen::Provisioner::ChefBase

  default_config :chef_gitref, "master"


end
