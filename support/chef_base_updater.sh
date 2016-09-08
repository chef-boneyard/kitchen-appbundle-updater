set -evx

export PATH=/opt/chef/bin:/opt/chef/embedded/bin:$PATH
sudo yum -y install git
pwd
git clone -v https://github.com/chef/appbundle-updater /appbundle-updater
pushd /appbundle-updater
pwd
git checkout jk/bundle-without-groups
bundle install
bundle exec rake install
popd
$gem install appbundler
$ruby $appbundle_updater chef chef $refname --tarball --github $github_owner/$github_repo
