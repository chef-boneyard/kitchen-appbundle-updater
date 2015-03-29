Function Make-WebClient {
  $proxy = New-Object -TypeName System.Net.WebProxy
  $proxy.Address = $env:http_proxy
  $client = New-Object -TypeName System.Net.WebClient
  $client.Proxy = $proxy
  return $client
}

Function Unzip-File($src, $dst) {
  $r = "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4"
  if (($PSVersionTable.PSVersion.Major -ge 3) -and ((gp "$r\Full").Version -like "4.5*" -or (gp "$r\Client").Version -like "4.5*")) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null; [System.IO.Compression.ZipFile]::ExtractToDirectory("$src", "$dst")
  } else {
    Try { $s = New-Object -ComObject Shell.Application; ($dp = $s.NameSpace($dst)).CopyHere(($z = $s.NameSpace($src)).Items(), 0x610) } Finally { Release-Com $s; Release-Com $z; Release-COM $dp }
  }
}

Function Update-Chef($gitref, $dstdir) {
  Write-Host "Updating Chef"

  $url = "https://github.com/chef/chef/archive/$($gitref).zip"
  $dstloc = "$dstdir\chef-$($gitref).zip"
  $unziploc = "$dstdir\chef-$($gitref)"
  Try {
    Log "Downloading chef from $url to $dst"
    ($c = Make-WebClient).DownloadFile($url, $dstloc)
    Log "Download complete."
  } Finally { if ($c -ne $null) { $c.Dispose() } }

  Write-Host "Unzipping $dstloc to $unziploc"
  Unzip-File $dstloc $unziploc

  Write-Host "Switching to $unziploc"
  Push-Location -Path $unziploc
  Try {
    Write-Host "Generating Gemfile.lock"
    $chef_omnibus_root\embedded\bin\bundle install --without server docgen test development
    $chef_omnibus_root\embedded\bin\appbundle "$chef_omnibus_root\embedded\apps\" "$chef_omnibus_root\bin"
  } Finally {
    Pop-Location
  }
}

Update-Chef "$gitref" "$($gitdir)\$($gitref)"
