set -e

$gem install appbundle-updater
$ruby $appbundle_updater chef chef $refname --tarball --github $github_owner/$github_repo
