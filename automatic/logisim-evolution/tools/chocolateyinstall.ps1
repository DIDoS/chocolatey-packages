﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName  
  FileFullPath  = "$toolsDir\logisim-evolution.jar"

  url           = 'https://github.com/logisim-evolution/logisim-evolution/releases/download/v3.7.1/logisim-evolution-3.7.1-all.jar'
  checksum      = 'd048dca69eb8c3865ec5e11296804d9cd68d118a91783af66328de6fe15f0913'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

# Install start menu shortcuts
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs "Logisim Evolution.lnk"
$targetPath = Join-Path $toolsDir "logisim-evolution.jar"
$iconLocation = "$toolsDir\logisim-evolution.ico"
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath -iconLocation $iconLocation

Write-Warning "You can launch `"Logisim Evolution`" from the start menu."
Write-Warning "Note: Java needs to be installed before using Logisim Evolution."
