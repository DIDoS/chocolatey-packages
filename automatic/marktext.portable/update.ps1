﻿import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {	
    $github_repository = "marktext/marktext"
    $releases = "https://github.com/" + $github_repository + "/releases/latest"
    $regex32  = '/.*-ia32-win.zip'
    $regex64  = '/v(?<Version>[\d\.]*)/.*-x64-win.zip'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing	
	$url32 = $download_page.links | ? href -match $regex32
    $url64 = $download_page.links | ? href -match $regex64

    return @{
        Version = $matches.Version
        URL32 = 'https://github.com' + $url32.href
        URL64 = 'https://github.com' + $url64.href
    }
}

function global:au_SearchReplace {
    @{
        "legal\VERIFICATION.txt"  = @{            
            "(?i)(x32).*"               = "`${1}$($Latest.URL32)"
            "(?i)(x64).*"               = "`${1}$($Latest.URL64)"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64:).*"       = "`${1} $($Latest.Checksum64)"
        }

        "tools\chocolateyinstall.ps1" = @{			
            "(marktext-)[\d\.]+(-\w+-win.zip)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}