set -e

# main
main() {
  url=`curl -s "https://api.github.com/repos/jdmundrawala/chef-appbundle-updater/releases/latest" | \
    "$chef_omnibus_root/embedded/bin/ruby" -rjson -e 'j=JSON.parse(STDIN.read); puts j["assets"][0]["browser_download_url"]'`
  sudo "$chef_omnibus_root/bin/chef-client" -z --recipe-url "$url" -o "recipe[chef-appbundle-updater::default]"
}

# augment path in an attempt to find a download program
PATH="${PATH}:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/sfw/bin";
export PATH;

main
