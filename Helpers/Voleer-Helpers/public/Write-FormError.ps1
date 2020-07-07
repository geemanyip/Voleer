<#
.SYNOPSIS
    This function displays an error message on the Voleer form. Mainly called within a validation script

.EXAMPLE
    try {
        # your code here

        if($error) {
            throw "I'm throwing an error"
        }
    }
    catch {
        # write error message on form
        Write-FormError $_
    }
#>
function Write-FormError {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # Exception
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Object]$Exception,

        # Stop execution
        [Parameter(Mandatory=$false)]
        [bool]$HaltExecution = $True
    )

    if($Exception.GetType() -eq [String]) {
        # Write message to form
        $context.SaveValidationMessage($Exception)
    }
    else {
        # Write message to form from exception
        $context.SaveValidationMessage($Exception.Exception.Message)
    }

    if($HaltExecution) {
        # stop further execution of the script
        throw
    }
}
