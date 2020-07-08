<#
.SYNOPSIS
    This function converts the an object to text
#>
function Convert-MWConnectorTypeToFriendlyName {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # markdown to escape
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Type
    )
    
    switch($Type) {

        "Hybrid" {
            return "Hybrid Exchange Project"
        }
        "Mailbox" {
            return "Mailbox Project"
        }
        "Storage" {
            return "Document Project"
        }
        "PublicFolder" {
            return "Public Folder Project"
        }
        "Archive" {
            return "Personal Archive Project"
        }
        "Teamwork" {
            return "Collaboration Project"
        }
    }

    return $Type
}
