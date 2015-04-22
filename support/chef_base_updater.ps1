$ErrorActionPreference = "Stop";

Function Log($m) { Write-Host "       $m`n" }

Function Update-Chef() {
  Log "Finding cookbook to update chef"
  Log $env:Path
  $env:Path = $env:Path + ";$chef_omnibus_root\bin\"
  $response = Invoke-WebRequest "https://api.github.com/repos/jdmundrawala/chef-appbundle-updater/releases/latest"
  $url = ($response.Content | ConvertFrom-Json).assets[0].browser_download_url
  Log "Running chef-client with recipe chef-appbundle-updater::default from $url"
  & "$chef_omnibus_root\bin\chef-client.bat" -z --recipe-url "$url" -j "$json" -o "recipe[chef-appbundle-updater::default]"
}

Update-Chef
