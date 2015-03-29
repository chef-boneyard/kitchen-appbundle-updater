$ErrorActionPreference = "Stop";

Function Log($m) { Write-Host "       $m`n" }

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
  $url = "https://github.com/chef/chef/archive/$gitref.zip"
  $dstloc = "$dstdir\chef-$($gitref).zip"
  $unziploc = "$dstdir\chef-$($gitref)"
  $newloc = "$dstdir\chef"

  if (Test-Path $unziploc) {
    Log "Removing existing checkout"
    Remove-Item $unziploc -Recurse -Force 
  }
  if (Test-Path $newloc) {
    Log "Removing existing checkout"
    Remove-Item $newloc -Recurse -Force 
  }

  Try {
    Log "Downloading chef from $url to $dstloc"
    ($c = Make-WebClient).DownloadFile($url, $dstloc)
    Log "Download complete."
  } Finally { if ($c -ne $null) { $c.Dispose() } }

  Log "Unzipping $dstloc to $unziploc"
  Unzip-File $dstloc $dstdir
  mv $unziploc $newloc

  Log "Switching to $newloc"
  Push-Location -Path $newloc
  Try {
    Log "Generating Gemfile.lock"
    & "$chef_omnibus_root\embedded\bin\bundle.bat" install --without server docgen test development
    & "$chef_omnibus_root\embedded\bin\appbundler.bat" "$newloc" "$chef_omnibus_root\bin"
  } Finally {
    Pop-Location
  }
  Log "Done`n"
}

Update-Chef $gitref $gitdir
