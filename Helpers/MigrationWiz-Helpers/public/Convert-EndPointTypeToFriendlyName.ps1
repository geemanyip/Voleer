<#
.SYNOPSIS
    This function converts the an object to text
#>
function Convert-EndPointTypeToFriendlyName {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # markdown to escape
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Type
    )
    
    switch($Type) {
        #
        # Mailbox Projects
        #

        "WorkMail" {
            return "AWS Workmail"
        }
        "Eml" {
            return "EML (Block Storage)"
        }
        "ExchangeServer" {
            return "Exchange Server 2003+"
        }
        "Gmail" {
            return "G Suite (IMAP)"
        }
        "GSuite" {
            return "G Suite (Gmail API)"
        }
        "GroupWise" {
            return "GroupWise 7+"
        }
        "IMAP" {
            return "IMAP"
        }
        "Lotus" {
            return "Lotus Notes 6.5+"
        }
        "ExchangeOnline2" {
            return "Office 365"
        }
        "ExchangeOnlineChina" {
            return "Office 365 (China)"
        }
        "ExchangeOnlineGermany" {
            return "Office 365 (Germany)"
        }
        "ExchangeOnlineUsGovernment" {
            return "Office 365 (US Government)"
        }
        "Office365Groups" {
            return "Office 365 Groups"
        }
        "OX" {
            return "Open-Xchange"
        }
        "POP" {
            return "POP"
        }
        "SonianArchivePhase1" {
            return "Sonian Archive Phase 1"
        }
        "Zimbra" {
            return "Zimbra 6+"
        }
        
        #
        # Document Projects
        #
        
        "AzureFileSystem" {
            return "Azure File System"
        }
        "DropBox" {
            return "Dropbox"
        }
        "GoogleDrive" {
            return "Google Drive"
        }
        "GoogleSites" {
            return "Google Sites"
        }
        "Office365Groups" {
            return "Office 365 Groups"
        }
        "OneDriveProAPI" {
            return "OneDrive for Business"
        }
        "SharePointOnlineAPI" {
            return "SharePoint"
        }

        #
        # Collaboration Projects
        #

        "MicrosoftTeamsSource" {
            return "Microsoft Teams"
        }
        "MicrosoftTeamsDestination" {
            return "Microsoft Teams"
        }
    }

    return $Type
}
