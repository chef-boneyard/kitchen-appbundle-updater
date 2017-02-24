set -e

$gem install appbundler appbundle-updater
[ ! -z "$ohai_refname" ] && $ruby $appbundle_updater chef ohai $ohai_refname --tarball --github chef/ohai
$ruby $appbundle_updater chef chef $refname --tarball --github $github_owner/$github_repo
