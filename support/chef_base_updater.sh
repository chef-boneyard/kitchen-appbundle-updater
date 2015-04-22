set -e

# main
main() {
  sudo "$chef_omnibus_root/bin/chef-client" -z --recipe-url "$cookbook_url" -j "$json" -o "recipe[chef-appbundle-updater::default]"
}

# augment path in an attempt to find a download program
PATH="${PATH}:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/sfw/bin";
export PATH;

main
