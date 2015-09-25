set -e

$gem install appbundle-updater
$appbundle_updater chef chef $refname --tarball
