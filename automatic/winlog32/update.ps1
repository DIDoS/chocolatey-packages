﻿import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -NoSuffix -Purge }

function global:au_GetLatest {
    $releases = 'http://www.winlog32.co.uk/dl_wl32update.htm'
    $url = 'http://www.winlog32.co.uk'
    #$regex   = 'v(.*?) \(rev\.(\d+)\)'
    $regex   = 'v([\d.]+)(\r\n| \(rev\.(\d+)\))'
    $regex_url = '/files/wl32v[\d]+.exe'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing    
    $download_page -match $regex
    $version_url = $matches[1].replace('.','')
    #$version = $matches[1] + "." + $matches[2]
    $version = $matches[1]
    $download_page -match $regex_url
    $url_path = $matches[0]

    return @{ Version = $version ; URL32 = $url + $matches[0] }
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
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}