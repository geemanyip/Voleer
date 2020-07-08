<#
.SYNOPSIS
    This function converts the an object to text
#>
function Convert-EscapeMarkdown {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # markdown to escape
        [Parameter(Mandatory=$false)]
        [String]$Markdown
    )

    $escaped = $Markdown

    # regex special characters 
    # [\^$.|?*+()

    # markdown special characters
    # \`*_{}[]()#+-.!|

    $escaped = $escaped -replace '[\[\]\(\)]', '\$0'
    #$escaped = $escaped -replace '[\\`\*_{}\[\]\(\)#\+\-\.!\|]', '\$0'
    
    return $escaped
}
