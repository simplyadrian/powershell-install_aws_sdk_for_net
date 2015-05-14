# Powershell 2.0


# Stop and fail script when a command fails.
$errorActionPreference = "Stop"

# load library functions
$rsLibDstDirPath = "$env:rs_sandbox_home\RightScript\lib"
. "$rsLibDstDirPath\tools\PsOutput.ps1"
. "$rsLibDstDirPath\tools\ResolveError.ps1"

try
{
    $aws_sdk = "AWS SDK for .NET"

    #check to see if the package is already installed
    if (Test-Path (${env:programfiles(x86)}+"\"+$aws_sdk)) { 
        $aws_sdk_path = ${env:programfiles(x86)}+"\"+$aws_sdk 
    } Elseif (Test-Path (${env:programfiles}+"\"+$aws_sdk)) { 
        $aws_sdk_path = ${env:programfiles}+"\"+$aws_sdk 
    }
    
    if ($aws_sdk_path -ne $null) 
    {
        Write-Output "*** AWS SDK for .NET already installed in [$aws_sdk_path]. Skipping installation."
    } 
    Else 
    {
        cd "$env:RS_ATTACH_DIR"
        Write-Output "*** Installing AWS SDK for .NET msi"
        cmd /c msiexec /package AWSToolsAndSDKForNet.msi /quiet
    }
}
catch
{
    ResolveError
    exit 1
}
