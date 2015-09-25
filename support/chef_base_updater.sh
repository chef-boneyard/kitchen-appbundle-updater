set -e

$gem install appbundle-updater
$appbundle_updater chef chef $refname --tarball --github $github_owner/$github_repo
