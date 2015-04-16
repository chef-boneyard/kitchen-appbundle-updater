set -e

# main
main() {
  url=`curl -s "https://api.github.com/repos/jdmundrawala/chef-appbundle-updater/releases/latest" | \
    /opt/chef/embedded/bin/ruby -rjson -e 'j=JSON.parse(STDIN.read); puts j["assets"][0]["browser_download_url"]'`
  sudo /opt/chef/bin/chef-solo -r "$url" -o "recipe[chef-appbundle-updater::default]"
}

# augment path in an attempt to find a download program
PATH="${PATH}:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/sfw/bin";
export PATH;

main
