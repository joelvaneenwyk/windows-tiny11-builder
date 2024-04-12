# Enable-PSRemoting -force -SkipNetworkProfileCheck

try {
    gsudo cache on

    gsudo Install-Module -Name PackageManagement -Force -AllowClobber
    gsudo Install-Module -Name PowerShellGet -Force -AllowClobber

    gsudo Install-PackageProvider -Name nuget -Force -ForceBootstrap -Scope allusers
    gsudo Update-Module PackageManagement, PowerShellGet -Force

    # run updates and installs in the background
    Start-Job { Install-Module PSScriptTools, PSTeachingTools -Force }
    Start-Job { Install-Module PSReleaseTools -Force; Install-PowerShell -mode quiet -enableremoting -EnableContextMenu }
    Start-Job { Install-Module WTToolbox -Force ; Install-WTRelease }
    #Start-Job -FilePath c:\scripts\install-vscodesandbox.ps1
    #Start-Job -FilePath c:\scripts\Set-SandboxDesktop.ps1

    # wait for everything to finish
    Get-Job | Wait-Job

    Import-Module PowerShellGet
    try {
        Import-Module WindowsSandboxTools
    }
    catch {
        Install-Module -Name WindowsSandboxTools
    }
    $params = @{
        Networking         = 'Default'
        LogonCommand       = 'c:\data\tiny11.bat'
        MemoryInMB         = 2048
        PrinterRedirection = 'Disable'
        MappedFolder       = @(
            New-WsbMappedFolder -HostFolder M:\projects\windows-tiny11-builder -SandboxFolder c:\data -ReadOnly,
            New-WsbMappedFolder -HostFolder M:\projects\windows-tiny11-builder -SandboxFolder c:\data -ReadOnly
        )
        Name               = 'MyDemo'
        Description        = 'A demo WSB configuration'
    }
    $new = New-WsbConfiguration @params
}
finally {
    gsudo cache off
}
