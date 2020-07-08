<#
.SYNOPSIS
    This function normalizes error messages by removing unique information so that we can
    consolidate the messages when attempting to group them
#>
function Convert-MWNormalizeErrorMessage {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # markdown to escape
        [Parameter(Mandatory=$false)]
        [String]$Message
    )

    $escaped = $Message

    # replace carriage returns and line feeds with a space
    $escaped = $escaped -replace "[\r\n]", " "

    # remove file paths at the end
    $escaped = $escaped -replace "\/.*$", "/removed/path"
    
    # email address
    $escaped = $escaped -replace "([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})", "user@domain.com"
    
    return $escaped
}
