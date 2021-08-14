﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"  

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  destination    = "$toolsDir"
  filefullpath   = "$toolsDir\dnscrypt-proxy-win32-2.1.0.zip"
  filefullpath64 = "$toolsDir\dnscrypt-proxy-win64-2.1.0.zip"
}

Get-ChocolateyUnzip @packageArgs
