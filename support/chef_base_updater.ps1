$ErrorActionPreference = "Stop";

Write-Host "-----> Installing appbundle-updater gem`n"
& "$gem" install appbundle-updater
Write-Host "-----> Running appbundle-updater to upgrade chef inside omnibus-chef`n"
& "$appbundle_updater" chef chef "$refname" --tarball --github "$github_owner/$github_repo"
