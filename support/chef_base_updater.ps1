$ErrorActionPreference = "Stop";

Function Log($m) { Write-Host "       $m`n" }

Log "Finding cookbook to update chef"
$env:Path = $env:Path + ";$chef_omnibus_root\bin\"
Log "Running chef-client with recipe chef-appbundle-updater::default from $cookbook_url"
& "$chef_omnibus_root\bin\chef-client.bat" -z --recipe-url "$cookbook_url" -j "$json" -o "recipe[chef-appbundle-updater::default]"
