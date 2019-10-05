﻿$ErrorActionPreference = 'Stop'
import-module au

function global:au_GetLatest {
	$releases = 'http://www.epidata.dk/download.php'
	$regex    = 'setup.all-in-one.(?<Version>[\d\.]+).exe'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url = $download_page.links | ? href -match $regex
    $version = $matches.Version

    return @{ Version = $matchesversion ; URL32 = 'http://www.epidata.dk/downloads/setup.all-in-one.' + $version + '.exe' }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
			"(^(\s)*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^(\s)*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

update