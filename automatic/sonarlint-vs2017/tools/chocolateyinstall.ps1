﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$file = "$toolsDir\SonarLint.VSIX-5.3.0.41207-2017.vsix"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  vsixUrl     = 'file://' + $file.Replace('\', '/')
}

Install-VisualStudioVsixExtension @packageArgs
