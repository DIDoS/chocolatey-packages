﻿import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
    $releases = 'http://rei.to/carotdav_en.html'
    $regex    = 'CarotDAV(?<Version>[\d\.]+).zip$'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.links | ? href -match $regex | Select -First 1

    return @{
        Version = $matches.Version
        URL32   = "http://rei.to/" + $url.href
    }
}

function global:au_SearchReplace {
    @{
        "legal\VERIFICATION.txt"  = @{
            "(?i)(x32: ).*"             = "`${1}$($Latest.URL32)"
            "(?i)(x64: ).*"             = "`${1}$($Latest.URL32)"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:).*"       = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64:).*"       = "`${1} $($Latest.Checksum32)"
        }

        "tools\chocolateyinstall.ps1" = @{
          "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\)(.*)`"" = "`$1$($Latest.FileName32)`""
          "(`"[$]toolsDir\\CarotDAV)[\d\.]+(\\CarotDAV)[\d\.]+(.msi`")" = "`${1}$($Latest.Version)`${2}$($Latest.Version)`${3}"
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}