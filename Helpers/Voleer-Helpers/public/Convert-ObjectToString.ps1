<#
.SYNOPSIS
    This function converts the the string representation back to the original object type
#>
function Convert-ObjectToString {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # The object to serialize
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Object]$ObjectToSerialize
    )

    # Convert the file contents to Base64 encoded bytes and return
    return ConvertTo-Json $ObjectToSerialize
}
