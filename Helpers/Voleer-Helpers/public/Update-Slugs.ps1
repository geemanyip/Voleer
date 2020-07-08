<#
.SYNOPSIS
    This function updates standard slugs we support for filenames
#>
function Update-Slugs {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # String to update
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$String        
    )

    $returnValue = $String
    $returnValue = $returnValue.Replace("[ticks]", (Get-Date).Ticks.ToString())

    # return new value
    return $returnValue
}
