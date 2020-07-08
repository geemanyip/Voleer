# Dumps .NET version into logs

Write-Information "Obtaining .NET framework versions available"

$versions = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
            Get-ItemProperty -name Version,Release -EA 0 |
            Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} |
            Select-Object PSChildName, Version, Release

foreach($version in $versions) {
    Write-Information "Name: $($version.PSChildName), Version: $($version.Version), Release: $($version.Release)"
}