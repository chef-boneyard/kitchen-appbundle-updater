set -e

$gem install appbundle-updater
appbundle-updater chef chef $refname
