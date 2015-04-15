# <a name="title"></a> kitchen-appbundle-updater

A Test Kitchen Driver that will use a version of Chef-Client from Github.
It provides a provisioner based on `Kitchen::Provisioner::ChefZero`. There
is currently no support for `chef-solo`.

## <a name="requirements"></a> Requirements
### Test-Kitchen
This provider requires [Test-Kitchen](https://github.com/test-kitchen/test-kitchen) `~> 1.4`.

## <a name="installation"></a> Installation and Setup
Add the following to your Gemfile:
```ruby
gem "test-kitchen", "~> 1.4.0.rc.1"
gem 'kitchen-appbundle-updater', git: "https://github.com/jdmundrawala/kitchen-appbundle-updater.git"
```

You can use the provided provisioner by modifying the `provisioner` section
in your `.kitchen.yml` to look like:
```yaml
provisioner:
  name: chef_github
```

## <a name="config"></a> Configuration

### <a name="config-chef-gitref"></a> chef\_gitref

The branch, tag, or SHA to use. The default value is `master`.

### <a name="config-chef-gitorg"></a> chef\_gitorg

The Github org or user which owns the repository. The default value is `chef`.

### <a name="config-chef-gitorg"></a> chef\_gitrepo

The name of the repository. The default value is `chef`.

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## <a name="authors"></a> Authors

Created and maintained by [Jay Mundrawala][author] (<jdmundrawala@gmail.com>)

## <a name="license"></a> License

Apache 2.0 (see [LICENSE][license])


[author]:           https://github.com/jdmundrawala
[issues]:           https://github.com/jdmundrawala/kitchen-appbundle-updater/issues
[license]:          https://github.com/jdmundrawala/kitchen-appbundle-updater/blob/master/LICENSE
[repo]:             https://github.com/jdmundrawala/kitchen-appbundle-updater
