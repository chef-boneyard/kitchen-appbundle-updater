require 'kitchen/provisioner/chef_base'

class Kitchen::Provisioner::ChefBase
  _install_command = instance_method(:install_command)
  def install_command
    raise "Here"
  end
end
