<#
.SYNOPSIS
    This function converts an object from the PSCustomObject type to a Hashtable type.
.DESCRIPTION
    The function code is adapted from https://stackoverflow.com/questions/3740128/pscustomobject-to-hashtable/34383413#34383413
#>
function Global:Convert-PSCustomObjectToHashtable {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([Hashtable])]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [AllowNull()]
        $Object
    )
    # Return null if a null object is provided
    if ($null -eq $Object) {
        return $null
    }
    # The object is an array, recursively evaluate all of the array items
    elseif ($Object -is [System.Collections.IEnumerable] -and $Object -isNot [String]) {
        $convertedArray = @()
        foreach ($item in $Object) {
            $convertedArray += (Convert-PSCustomObjectToHashtable $item)
        }
        return $convertedArray
    }
    # The object is a PSObject, recursively evaluate all object properties
    elseif ($Object -is [PSObject]) {
        $convertedHashtable = @{}
        foreach ($property in $Object.PSObject.Properties) {
            $convertedHashtable[$property.Name] = Convert-PSCustomObjectToHashtable $property.Value
        }
        return $convertedHashtable
    }
    # Return the object as it is
    else {
        return $Object
    }
}