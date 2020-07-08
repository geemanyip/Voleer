<#
.SYNOPSIS
    This function converts the an object to text
#>
function Convert-StringToObject {
    [CmdletBinding(PositionalBinding=$true)]
    [OutputType([String])]
    param (
        # string object to deserialized
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$SerializedObject,
        
        # string object to deserialized
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Type]$SerializedObjectType
    )

    $serializer = [System.Web.Script.Serialization.JavaScriptSerializer]::new()

    # Convert the file contents to Base64 encoded bytes and return
    return $serializer.Deserialize($SerializedObject, $SerializedObjectType)
}
